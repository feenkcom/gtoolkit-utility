"
I estimate the memory space used by objects, by walking over the objects reachable from them and adding their size to a {{gtClass:GtMemorySpaceEstimate}}. I am the engine used by attributions ({{gtClass:GtMemorySpaceAttribution}}) and estimations ({{gtClass:GtMemorySpaceEstimation}}).

Every object is counted once, the first time it is reached; objects are compared by identity. The objects counted are remembered across walks, so several walks with different categories give a breakdown in which each object is counted only once, in the category of the first walk that reaches it.

A {{gtClass:GtMemorySpaceBoundary}} decides where a walk stops and which objects are tagged. How the instances of a class are traversed is decided once per class by a {{gtClass:GtMemorySpaceClassTraversal}}: weak references are not followed, and neither is the key of ephemerons, as they do not keep their key alive.

My two primitives are:
- #estimate:inCategory:into: adds all objects reachable from an object that were not counted before;
- #estimateObject:inCategory:into: adds only the object itself, even if the boundary stops at its class. This allows counting roots, like the pages of a Lepiter database, while stopping walks at the other roots.

The traversal is designed to be fast for millions of objects: decisions are cached per class, the stack is reused, and no objects are created for each visited object. For large walks, presize the set of visited objects with #expectedObjects:. After a run, #releaseVisitedObjects frees the set of visited objects.

See {{gtClass:GtMemorySpaceEstimatorExamples}} for how objects are counted.
"
Class {
	#name : #GtMemorySpaceEstimator,
	#superclass : #Object,
	#instVars : [
		'boundary',
		'visited',
		'objectsCountAtRelease',
		'stack',
		'classTraversals',
		'walkTagSizes',
		'hasWalkTags'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #private }
GtMemorySpaceEstimator >> addWalkSize: aSize ofTag: aTag [
	walkTagSizes at: aTag put: (walkTagSizes at: aTag ifAbsent: [ 0 ]) + aSize.
	hasWalkTags := true
]

{ #category : #accessing }
GtMemorySpaceEstimator >> allClassTraversals [
	^ GtMemorySpaceClassTraversalGroup
		named: 'all classes'
		traversals: self classTraversals
]

{ #category : #accessing }
GtMemorySpaceEstimator >> boundary [
	^ boundary
]

{ #category : #accessing }
GtMemorySpaceEstimator >> boundary: aBoundary [
	boundary := aBoundary.
	classTraversals := IdentityDictionary new
]

{ #category : #accessing }
GtMemorySpaceEstimator >> classTraversals [
	"The traversals of the classes seen so far"

	^ classTraversals values
]

{ #category : #accessing }
GtMemorySpaceEstimator >> classTraversalsByTag [
	"Groups of traversals: one per tag (in the order of the boundary), 
	then classes counted without a tag, then classes not counted. Empty groups are omitted."

	| traversals groups |
	traversals := self classTraversals.
	groups := OrderedCollection new.
	boundary tags
		do: [ :aTag | 
			groups
				add: ((GtMemorySpaceClassTraversalGroup
						named: aTag name asString
						traversals: (traversals select: [ :each | each tag == aTag ]))
						tag: aTag;
						yourself) ].
	groups
		add: (GtMemorySpaceClassTraversalGroup
				named: 'not tagged'
				traversals: (traversals select: [ :each | each isCounted and: [ each tag isNil ] ])).
	groups add: self notCountedClassTraversals.
	^ groups reject: [ :each | each isEmpty ]
]

{ #category : #accessing }
GtMemorySpaceEstimator >> countedClassTraversals [
	^ GtMemorySpaceClassTraversalGroup
		named: 'counted'
		traversals: (self classTraversals select: [ :each | each isCounted ])
]

{ #category : #estimating }
GtMemorySpaceEstimator >> estimate: anObject inCategory: aCategory into: anEstimate [
	"Add to aCategory all objects reachable from anObject that were not counted before"

	| size count |
	size := 0.
	count := 0.
	stack addLast: anObject.
	[ stack isEmpty ]
		whileFalse: [ | current traversal |
			current := stack removeLast.
			traversal := self traversalForClass: current class.
			(traversal isCounted and: [ (visited includes: current) not ])
				ifTrue: [ | currentSize |
					visited add: current.
					currentSize := current sizeInMemory.
					size := size + currentSize.
					count := count + 1.
					traversal tag
						ifNotNil: [ :aTag | self addWalkSize: currentSize ofTag: aTag ].
					traversal pushReferencesOf: current onto: stack ] ].

	anEstimate
		addBytes: size
		objectsCount: count
		toCategory: aCategory.
	hasWalkTags
		ifTrue: [ self flushWalkTagSizesToCategory: aCategory into: anEstimate ]
]

{ #category : #estimating }
GtMemorySpaceEstimator >> estimateObject: anObject inCategory: aCategory into: anEstimate [
	"Add only anObject to aCategory, without the objects it references.
	anObject is counted even if the boundary stops at its class."

	| size |
	(self shouldCountExplicitly: anObject) ifFalse: [ ^ self ].

	visited add: anObject.
	size := anObject sizeInMemory.
	anEstimate
		addBytes: size
		objectsCount: 1
		toCategory: aCategory.
	(self traversalForClass: anObject class) tag
		ifNotNil: [ :aTag | 
			anEstimate
				addBytes: size
				ofTag: aTag name
				toCategory: aCategory ]
]

{ #category : #initialization }
GtMemorySpaceEstimator >> expectedObjects: aNumber [
	"Presize the set of visited objects, before the first walk. 
	Growing a very large set is slow, and creates a lot of work for the garbage collector."

	(aNumber > 0 and: [ visited notNil and: [ visited isEmpty ] ])
		ifTrue: [ visited := IdentitySet new: aNumber ]
]

{ #category : #private }
GtMemorySpaceEstimator >> flushWalkTagSizesToCategory: aCategory into: anEstimate [
	walkTagSizes
		associationsDo: [ :anAssociation | 
			anAssociation value > 0
				ifTrue: [ anEstimate
						addBytes: anAssociation value
						ofTag: anAssociation key name
						toCategory: aCategory.
					anAssociation value: 0 ] ].
	hasWalkTags := false
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimator >> gtViewClassTraversalsByTagFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'By tag';
		priority: 15;
		items: [ self classTraversalsByTag ];
		children: [ :each | 
			(each isKindOf: GtMemorySpaceClassTraversalGroup)
				ifTrue: [ each traversals ]
				ifFalse: [ #() ] ];
		column: 'Class'
			text: [ :each | 
				(each isKindOf: GtMemorySpaceClassTraversalGroup)
					ifTrue: [ each name , ' (' , each classesCount asString , ' classes)' ]
					ifFalse: [ each traversedClass name ] ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimator >> gtViewClassTraversalsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Class traversals';
		priority: 10;
		items: [ self classTraversals
				asSortedCollection: [ :a :b | a traversedClass name <= b traversedClass name ] ];
		column: 'Class' text: [ :each | each traversedClass name ];
		column: 'Counted'
			text: [ :each | each isCounted ]
			width: 70;
		column: 'Tag'
			text: [ :each | each tag ifNil: [ '' ] ifNotNil: [ :aTag | aTag name ] ]
			width: 100
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimator >> gtViewOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 5;
		items: [ self overviewItems ];
		column: 'Property'
			text: [ :each | each first ]
			width: 180;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #initialization }
GtMemorySpaceEstimator >> initialize [
	super initialize.
	boundary := GtMemorySpaceBoundary default.
	visited := IdentitySet new.
	stack := OrderedCollection new: 1000.
	classTraversals := IdentityDictionary new.
	walkTagSizes := IdentityDictionary new.
	hasWalkTags := false
]

{ #category : #testing }
GtMemorySpaceEstimator >> isVisited: anObject [
	^ visited includes: anObject
]

{ #category : #accessing }
GtMemorySpaceEstimator >> notCountedClassTraversals [
	^ GtMemorySpaceClassTraversalGroup
		named: 'not counted'
		traversals: (self classTraversals reject: [ :each | each isCounted ])
]

{ #category : #accessing }
GtMemorySpaceEstimator >> objectsCount [
	"The number of objects counted so far"

	^ visited ifNil: [ objectsCountAtRelease ] ifNotNil: [ visited size ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimator >> overviewItems [
	"Arrays with a label, a value to display and an object to inspect"

	| items |
	items := OrderedCollection new.
	items
		add: {'Objects counted'.
				self objectsCount.
				visited};
		add: {'Classes seen'.
				classTraversals size.
				self allClassTraversals};
		add: {'Classes counted'.
				self countedClassTraversals classesCount.
				self countedClassTraversals};
		add: {'Classes not counted'.
				self notCountedClassTraversals classesCount.
				self notCountedClassTraversals}.
	self classTraversalsByTag
		do: [ :aGroup | 
			aGroup tag
				ifNotNil: [ :aTag | 
					items
						add: {'Classes tagged ' , aTag name printString.
								aGroup classesCount.
								aGroup} ] ].
	items
		add: {'Stop classes'.
				', ' join: (boundary stopClasses collect: [ :each | each name ]).
				boundary stopClasses};
		add: {'Tags'.
				', ' join: (boundary tags collect: [ :each | each name asString ]).
				boundary tags};
		add: {'Boundary'.
				boundary printString.
				boundary}.
	^ items
]

{ #category : #initialization }
GtMemorySpaceEstimator >> releaseVisitedObjects [
	"Release the set of visited objects, which can be very large, when no more objects will be estimated. 
	The class traversals are kept, for inspecting them."

	objectsCountAtRelease := self objectsCount.
	visited := nil.
	stack := nil
]

{ #category : #testing }
GtMemorySpaceEstimator >> shouldCountExplicitly: anObject [
	"Objects given explicitly are counted even if the boundary stops at their class;
	the boundary only applies to the objects reached from them"

	(anObject isNil or: [ anObject == true or: [ anObject == false ] ])
		ifTrue: [ ^ false ].
	anObject class isImmediateClass ifTrue: [ ^ false ].
	^ (visited includes: anObject) not
]

{ #category : #accessing }
GtMemorySpaceEstimator >> traversalForClass: aClass [
	"How instances of aClass are traversed. Created once per class, 
	as making these decisions for each object is slow.
	We avoid #at:ifAbsentPut: here, as it would create a block for every object."

	^ (classTraversals at: aClass ifAbsent: nil)
		ifNil: [ classTraversals
				at: aClass
				put: (GtMemorySpaceClassTraversal forClass: aClass boundary: boundary) ]
]
