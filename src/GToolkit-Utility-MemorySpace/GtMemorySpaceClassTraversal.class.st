"
I decide how a {{gtClass:GtMemorySpaceEstimator}} traverses the instances of a class: whether they are counted (the {{gtClass:GtMemorySpaceBoundary}} does not stop at the class), their tag ({{gtClass:GtMemorySpaceTag}}), and which of their references are followed.

Fixed slots are followed, except the key of ephemerons, as ephemerons do not keep their key alive. Indexed slots are followed for objects with pointers that are not weak. The literals of compiled code are not followed.

I am created once per class and cached by the estimator, so that all decisions about a class are made only once, and not for every object.
"
Class {
	#name : #GtMemorySpaceClassTraversal,
	#superclass : #Object,
	#instVars : [
		'traversedClass',
		'isCounted',
		'tag',
		'firstSlotIndex',
		'lastSlotIndex',
		'followsIndexedSlots',
		'slotNames'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceClassTraversal class >> forClass: aClass boundary: aBoundary [
	^ self new
		initializeForClass: aClass boundary: aBoundary;
		yourself
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> firstSlotIndex [
	"The first named slot that is followed; the key of an ephemeron is not"

	^ firstSlotIndex
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> followedSlotNames [
	^ (firstSlotIndex to: lastSlotIndex)
		collect: [ :anIndex | self slotNames at: anIndex ]
]

{ #category : #testing }
GtMemorySpaceClassTraversal >> followsIndexedSlots [
	^ followsIndexedSlots
]

{ #category : #'gt - extensions' }
GtMemorySpaceClassTraversal >> gtViewDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ {'Class' -> traversedClass.
				'Counted' -> isCounted.
				'Tag' -> tag.
				'Followed slots'
					-> (isCounted ifTrue: [ ', ' join: self followedSlotNames ] ifFalse: [ '' ]).
				'Follows indexed slots' -> (isCounted and: [ followsIndexedSlots ])} ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ifNil: [ '' ] ];
		send: [ :each | each value ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceClassTraversal >> gtViewFollowedSlotsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Followed slots';
		priority: 15;
		items: [ self slotsDescription ];
		column: 'Index'
			text: [ :each | each first ]
			width: 70;
		column: 'Slot' text: [ :each | each second ];
		column: 'Followed' text: [ :each | each third ]
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> indexedSlotsDescription [
	followsIndexedSlots ifTrue: [ ^ 'yes' ].
	traversedClass isWeak ifTrue: [ ^ 'no (weak references)' ].
	(traversedClass includesBehavior: CompiledCode)
		ifTrue: [ ^ 'no (bytecodes; literals of compiled code are not followed)' ].
	^ 'no (raw data, not references)'
]

{ #category : #initialization }
GtMemorySpaceClassTraversal >> initializeForClass: aClass boundary: aBoundary [
	traversedClass := aClass.
	isCounted := (aBoundary shouldStopAtClass: aClass) not.
	tag := isCounted ifTrue: [ aBoundary tagForClass: aClass ] ifFalse: [ nil ].
	firstSlotIndex := aClass isEphemeronClass ifTrue: [ 2 ] ifFalse: [ 1 ].
	lastSlotIndex := aClass instSize.
	followsIndexedSlots := aClass isVariable
			and: [ aClass isPointers and: [ aClass isWeak not ] ]
]

{ #category : #testing }
GtMemorySpaceClassTraversal >> isCounted [
	"Answer whether instances are counted when reached by a walk"

	^ isCounted
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> lastSlotIndex [
	^ lastSlotIndex
]

{ #category : #printing }
GtMemorySpaceClassTraversal >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: traversedClass;
		nextPutAll: (isCounted ifTrue: [ ', counted' ] ifFalse: [ ', not counted' ]).
	tag
		ifNotNil: [ aStream
				nextPutAll: ', tag ';
				print: tag name ].
	aStream nextPut: $)
]

{ #category : #traversing }
GtMemorySpaceClassTraversal >> pushReferencesOf: anObject onto: aStack [
	"Push the objects referenced by anObject that should be followed"

	firstSlotIndex
		to: lastSlotIndex
		do: [ :anIndex | aStack addLast: (anObject instVarAt: anIndex) ].
	followsIndexedSlots
		ifTrue: [ 1
				to: anObject basicSize
				do: [ :anIndex | aStack addLast: (anObject basicAt: anIndex) ] ]
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> slotNames [
	"The names of the fixed slots, computed only when needed (for splitting an object by its slots)"

	^ slotNames ifNil: [ slotNames := traversedClass allInstVarNames ]
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> slotsDescription [
	"Arrays with the index, the name and whether each slot is followed (with the reason if not). 
	Indexed slots are described in one entry."

	| slots notCounted |
	notCounted := 'no (the boundary stops at this class)'.
	slots := (1 to: lastSlotIndex)
			collect: [ :anIndex | 
				{anIndex printString.
					self slotNames at: anIndex.
					isCounted not
						ifTrue: [ notCounted ]
						ifFalse: [ anIndex < firstSlotIndex
								ifTrue: [ 'no (key of an ephemeron)' ]
								ifFalse: [ 'yes' ] ]} ]
			as: OrderedCollection.
	traversedClass isVariable
		ifTrue: [ slots
				add: {'indexed'.
						'indexed slots'.
						isCounted not
							ifTrue: [ notCounted ]
							ifFalse: [ self indexedSlotsDescription ]} ].
	^ slots
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> tag [
	"The tag of instances, or nil"

	^ tag
]

{ #category : #accessing }
GtMemorySpaceClassTraversal >> traversedClass [
	^ traversedClass
]
