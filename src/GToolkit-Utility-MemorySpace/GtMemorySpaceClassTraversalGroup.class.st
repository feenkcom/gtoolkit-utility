"
I group class traversals ({{gtClass:GtMemorySpaceClassTraversal}}) of a {{gtClass:GtMemorySpaceEstimator}}, for example the classes with a tag, or the classes that are not counted.
"
Class {
	#name : #GtMemorySpaceClassTraversalGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'tag',
		'traversals'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceClassTraversalGroup class >> named: aName traversals: aCollectionOfTraversals [
	^ self new
		name: aName;
		traversals: aCollectionOfTraversals;
		yourself
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> classes [
	^ traversals collect: [ :each | each traversedClass ]
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> classesCount [
	^ self traversals size
]

{ #category : #'gt - extensions' }
GtMemorySpaceClassTraversalGroup >> gtViewTraversalsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Classes';
		priority: 10;
		items: [ self traversals ];
		column: 'Class' text: [ :each | each traversedClass name ];
		column: 'Counted'
			text: [ :each | each isCounted ]
			width: 70;
		column: 'Tag'
			text: [ :each | each tag ifNil: [ '' ] ifNotNil: [ :aTag | aTag name ] ]
			width: 100
]

{ #category : #testing }
GtMemorySpaceClassTraversalGroup >> isEmpty [
	^ traversals isEmpty
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> name [
	^ name
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> name: aName [
	name := aName
]

{ #category : #printing }
GtMemorySpaceClassTraversalGroup >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: name asString;
		nextPutAll: ', ';
		print: self classesCount;
		nextPutAll: ' classes)'
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> tag [
	"The tag of the classes in this group, or nil"

	^ tag
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> tag: aTag [
	tag := aTag
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> traversals [
	^ traversals ifNil: [ #() ]
]

{ #category : #accessing }
GtMemorySpaceClassTraversalGroup >> traversals: aCollectionOfTraversals [
	traversals := (aCollectionOfTraversals
			asSortedCollection: [ :a :b | a traversedClass name <= b traversedClass name ])
			asArray
]
