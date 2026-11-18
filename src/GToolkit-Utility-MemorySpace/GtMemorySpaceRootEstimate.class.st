"
I hold the memory added by one root ({{gtClass:GtMemorySpaceRoot}}) of a {{gtClass:GtMemorySpaceRootGroup}}: the objects reached from it that were not counted before.
"
Class {
	#name : #GtMemorySpaceRootEstimate,
	#superclass : #Object,
	#instVars : [
		'root',
		'group',
		'category',
		'bytes',
		'objectsCount'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceRootEstimate class >> root: aRoot group: aRootGroup category: aCategory bytes: aNumberOfBytes objectsCount: aNumberOfObjects [
	^ self new
		setRoot: aRoot
		group: aRootGroup
		category: aCategory
		bytes: aNumberOfBytes
		objectsCount: aNumberOfObjects
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> bytes [
	^ bytes
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> category [
	"The category of the root, or nil if the attribution of its group split it"

	^ category
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> categoryName [
	^ category
		ifNil: [ 'several categories' ]
		ifNotNil: [ GtMemorySpaceCategory nameOf: category ]
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> group [
	^ group
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> label [
	^ root label
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> objectsCount [
	^ objectsCount
]

{ #category : #printing }
GtMemorySpaceRootEstimate >> printOn: aStream [
	super printOn: aStream.
	root ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self label;
		nextPutAll: ': ';
		nextPutAll: bytes humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceRootEstimate >> root [
	^ root
]

{ #category : #initialization }
GtMemorySpaceRootEstimate >> setRoot: aRoot group: aRootGroup category: aCategory bytes: aNumberOfBytes objectsCount: aNumberOfObjects [
	root := aRoot.
	group := aRootGroup.
	category := aCategory.
	bytes := aNumberOfBytes.
	objectsCount := aNumberOfObjects
]
