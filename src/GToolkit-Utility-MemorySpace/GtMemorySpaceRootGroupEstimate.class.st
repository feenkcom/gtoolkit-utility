"
I hold the memory added by the roots of one {{gtClass:GtMemorySpaceRootGroup}}, computed from their {{gtClass:GtMemorySpaceRootEstimate}}s.
"
Class {
	#name : #GtMemorySpaceRootGroupEstimate,
	#superclass : #Object,
	#instVars : [
		'group',
		'bytes',
		'objectsCount',
		'rootEstimates'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceRootGroupEstimate class >> group: aRootGroup rootEstimates: aCollectionOfRootEstimates [
	^ self new setGroup: aRootGroup rootEstimates: aCollectionOfRootEstimates
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> bytes [
	^ bytes
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> group [
	^ group
]

{ #category : #'gt - extensions' }
GtMemorySpaceRootGroupEstimate >> gtViewRootsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Roots';
		priority: 10;
		items: [ self sortedRootEstimates ];
		column: 'Root' text: [ :each | each label ];
		column: 'Category'
			text: [ :each | each categoryName ]
			width: 200;
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Objects'
			text: [ :each | each objectsCount ]
			width: 80;
		send: [ :each | each root object ]
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> label [
	^ group label
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> objectsCount [
	^ objectsCount
]

{ #category : #printing }
GtMemorySpaceRootGroupEstimate >> printOn: aStream [
	super printOn: aStream.
	group ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self label;
		nextPutAll: ': ';
		nextPutAll: bytes humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> rootEstimates [
	^ rootEstimates ifNil: [ #() ]
]

{ #category : #initialization }
GtMemorySpaceRootGroupEstimate >> setGroup: aRootGroup rootEstimates: aCollectionOfRootEstimates [
	group := aRootGroup.
	rootEstimates := aCollectionOfRootEstimates asArray.
	bytes := rootEstimates inject: 0 into: [ :aSum :each | aSum + each bytes ].
	objectsCount := rootEstimates
			inject: 0
			into: [ :aSum :each | aSum + each objectsCount ]
]

{ #category : #accessing }
GtMemorySpaceRootGroupEstimate >> sortedRootEstimates [
	^ self rootEstimates asArray sort: [ :a :b | a bytes > b bytes ]
]
