"
I hold, for one class of a {{gtClass:GtMemorySpaceRetention}}, its instances (how many, and their own memory) and the memory retained through them: reached only through instances of the retained classes, including my instances.

When several classes are retained, memory reached only through instances of several of them goes to the first class in their order. The memory also reached from other places (shared) is only known for all classes together, in the retention.
"
Class {
	#name : #GtMemorySpaceClassRetention,
	#superclass : #Object,
	#instVars : [
		'retainedClass',
		'instancesCount',
		'instancesBytes',
		'retainedBytes'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceClassRetention >> instancesBytes [
	"The memory of the instances themselves"

	^ instancesBytes ifNil: [ 0 ]
]

{ #category : #accessing }
GtMemorySpaceClassRetention >> instancesCount [
	^ instancesCount ifNil: [ 0 ]
]

{ #category : #printing }
GtMemorySpaceClassRetention >> printOn: aStream [
	super printOn: aStream.
	retainedClass ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: retainedClass name;
		nextPutAll: ': ';
		print: self instancesCount;
		nextPutAll: ' instances, ';
		nextPutAll: self retainedBytes humanReadableIsqByteSize;
		nextPutAll: ' retained';
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceClassRetention >> retainedBytes [
	"The memory reached only through the instances of the retained classes, and first through mine, 
	including my instances"

	^ retainedBytes ifNil: [ 0 ]
]

{ #category : #accessing }
GtMemorySpaceClassRetention >> retainedClass [
	^ retainedClass
]

{ #category : #initialization }
GtMemorySpaceClassRetention >> setClass: aClass instances: aCollectionOfInstances retainedBytes: aRetainedBytes [
	retainedClass := aClass.
	instancesCount := aCollectionOfInstances size.
	instancesBytes := aCollectionOfInstances
			inject: 0
			into: [ :aSum :each | aSum + each sizeInMemory ].
	retainedBytes := aRetainedBytes
]
