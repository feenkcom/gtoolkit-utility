"
I am a named group of roots ({{gtClass:GtMemorySpaceRoot}}) in a {{gtClass:GtMemorySpaceRootsDefinition}}. My roots are computed when an estimation runs, from a block or a collection; plain objects are turned into roots.

The memory of my roots goes to my category, unless a root names its own category, or I have an attribution that splits each root into several categories.

Groups are estimated in order and every object is counted once, so the memory of objects reachable from several groups goes to the first group. Put specific groups first, and groups that reach almost everything, like the UI, last. A group can also stop at more classes than its definition (#stopAtInstancesOf:), for example at objects shared by the whole system; the groups that follow still count them.

My class side has ready-made groups: #classSideState and #globals.
"
Class {
	#name : #GtMemorySpaceRootGroup,
	#superclass : #Object,
	#instVars : [
		'label',
		'category',
		'rootsComputation',
		'attribution',
		'extraStopClasses'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #private }
GtMemorySpaceRootGroup class >> classSideRootsOf: aCollectionOfClasses [
	"Roots for the values of class variables and of class-side instance variables.
	Class-side instance variables are the slots defined by metaclasses; 
	the slots of the kernel, like the method dictionaries of classes using traits, are code."

	^ Array
		streamContents: [ :aStream | 
			aCollectionOfClasses
				do: [ :aClass | 
					aClass isTrait
						ifFalse: [ | aPackageName |
							aPackageName := aClass package
									ifNil: [ 'Unpackaged' ]
									ifNotNil: [ :aPackage | aPackage name ].
							aClass classPool
								keysAndValuesDo: [ :aName :aValue | 
									(self isRootValue: aValue)
										ifTrue: [ aStream
												nextPut: (GtMemorySpaceRoot
														label: aClass name , ' class var ' , aName
														object: aValue
														categoryName: aPackageName) ] ].
							aClass class allSlots
								do: [ :aSlot | 
									aSlot definingClass isMeta
										ifTrue: [ | aValue |
											aValue := aSlot read: aClass.
											(self isRootValue: aValue)
												ifTrue: [ aStream
														nextPut: (GtMemorySpaceRoot
																label: aClass name , ' class-side ' , aSlot name
																object: aValue
																categoryName: aPackageName) ] ] ] ] ] ]
]

{ #category : #'instance creation' }
GtMemorySpaceRootGroup class >> classSideState [
	"The values of the class variables and class-side instance variables of all classes, 
	attributed to the package of their class"

	^ self
		label: 'Class-side state'
		roots: [ self classSideRootsOf: Smalltalk allClasses ]
]

{ #category : #'instance creation' }
GtMemorySpaceRootGroup class >> classSideStateOf: aCollectionOfClasses [
	"The values of the class variables and class-side instance variables of the classes, 
	attributed to the package of their class"

	^ self
		label: 'Class-side state'
		roots: [ self classSideRootsOf: aCollectionOfClasses ]
]

{ #category : #'instance creation' }
GtMemorySpaceRootGroup class >> globals [
	"The values of the globals that are not classes"

	^ self
		label: 'Globals'
		roots: [ Array
				streamContents: [ :aStream | 
					Smalltalk globals
						associationsDo: [ :anAssociation | 
							(anAssociation value isBehavior not
								and: [ self isRootValue: anAssociation value ])
								ifTrue: [ aStream
										nextPut: (GtMemorySpaceRoot
												label: 'global ' , anAssociation key
												object: anAssociation value) ] ] ] ]
]

{ #category : #private }
GtMemorySpaceRootGroup class >> isRootValue: anObject [
	"Immediate objects and nil take no memory of their own"

	^ anObject notNil and: [ anObject class isImmediateClass not ]
]

{ #category : #'instance creation' }
GtMemorySpaceRootGroup class >> label: aString roots: aBlockOrCollection [
	"aBlockOrCollection answers the roots: GtMemorySpaceRoot objects, or plain objects"

	^ self new setLabel: aString roots: aBlockOrCollection
]

{ #category : #private }
GtMemorySpaceRootGroup >> asRoot: anObject [
	(anObject isKindOf: GtMemorySpaceRoot) ifTrue: [ ^ anObject ].
	^ GtMemorySpaceRoot
		label: ([ anObject printStringLimitedTo: 80 ]
				on: Error
				do: [ :anError | 'a ' , anObject class name ])
		object: anObject
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> attribution [
	^ attribution
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> attribution: anAttribution [
	"Split each root with anAttribution, instead of attributing it to a single category"

	attribution := anAttribution
]

{ #category : #estimating }
GtMemorySpaceRootGroup >> attributionFor: aRoot in: aDefinition [
	^ attribution
		ifNil: [ GtMemorySpaceAttribution toCategory: (self categoryFor: aRoot in: aDefinition) ]
]

{ #category : #estimating }
GtMemorySpaceRootGroup >> boundaryWithin: aBoundary [
	"The boundary used while my roots are walked"

	^ self extraStopClasses
		ifEmpty: [ aBoundary ]
		ifNotEmpty: [ :theClasses | aBoundary copyStoppingAtInstancesOf: theClasses ]
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> category [
	"The category of my roots, unless a root names its own"

	^ category
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> category: aCategory [
	category := aCategory
]

{ #category : #estimating }
GtMemorySpaceRootGroup >> categoryFor: aRoot in: aDefinition [
	"The category of aRoot, or nil if my attribution splits it into several categories"

	attribution
		ifNotNil: [ | theCategories |
			theCategories := attribution categories.
			^ theCategories size = 1 ifTrue: [ theCategories first ] ifFalse: [ nil ] ].
	^ aRoot categoryName
		ifNil: [ category ]
		ifNotNil: [ :aName | aDefinition categoryNamed: aName ]
]

{ #category : #estimating }
GtMemorySpaceRootGroup >> estimateRoot: aRoot in: aDefinition with: anEstimator into: anEstimate [
	"Add the objects reachable from aRoot that were not counted before"

	attribution
		ifNotNil: [ ^ attribution
				estimate: aRoot object
				with: anEstimator
				into: anEstimate ].
	anEstimator
		estimate: aRoot object
		inCategory: (self categoryFor: aRoot in: aDefinition)
		into: anEstimate
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> extraStopClasses [
	^ extraStopClasses ifNil: [ #() ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceRootGroup >> gtViewRootsFor: aView [
	<gtView>
	rootsComputation ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Roots';
		priority: 10;
		items: [ self roots ];
		column: 'Root' text: [ :each | each label ];
		column: 'Category'
			text: [ :each | each categoryName ifNil: [ GtMemorySpaceCategory nameOf: category ] ]
			width: 200;
		send: [ :each | each object ]
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> label [
	^ label
]

{ #category : #printing }
GtMemorySpaceRootGroup >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (label ifNil: [ '' ]);
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> roots [
	"My roots, computed now"

	^ Array
		streamContents: [ :aStream | self rootsDo: [ :each | aStream nextPut: each ] ]
]

{ #category : #enumerating }
GtMemorySpaceRootGroup >> rootsDo: aBlock [
	| theRoots |
	theRoots := rootsComputation isBlock
			ifTrue: [ rootsComputation value ]
			ifFalse: [ rootsComputation ].
	theRoots do: [ :each | aBlock value: (self asRoot: each) ]
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> rule [
	"How my roots are attributed, for views"

	^ GtMemorySpaceRule
		label: label
		attribution: (attribution ifNil: [ GtMemorySpaceAttribution toCategory: category ])
]

{ #category : #initialization }
GtMemorySpaceRootGroup >> setLabel: aString roots: aBlockOrCollection [
	label := aString.
	rootsComputation := aBlockOrCollection
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> stopAtInstancesOf: aCollectionOfClasses [
	"While my roots are walked, also stop at instances of these classes, 
	for example at objects shared by many parts of the system. 
	Objects not counted because of them can be counted by the groups that follow."

	extraStopClasses := self extraStopClasses , aCollectionOfClasses asArray
]

{ #category : #accessing }
GtMemorySpaceRootGroup >> summary [
	| aSummary |
	aSummary := attribution
			ifNil: [ (GtMemorySpaceCategory nameOf: category)
					, ', or the category named by each root' ]
			ifNotNil: [ attribution summary ].
	^ self extraStopClasses
		ifEmpty: [ aSummary ]
		ifNotEmpty: [ :theClasses | 
			aSummary , '; also stops at '
				, (', ' join: (theClasses collect: [ :each | each name ])) ]
]
