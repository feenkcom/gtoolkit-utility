"
I estimate the memory kept by the instances of some classes, for example by the history of a server, and split the memory reached through them in two:
- the memory reached **only through** the instances (retained): it would be freed without them;
- the memory **also reached from other places** (shared): it would stay.

I start from an estimation ({{gtClass:GtMemorySpaceEstimation}}) of a {{gtClass:GtMemorySpaceRootsDefinition}}. I walk its roots again while stopping at the instances, and then continue the same walk from the instances: what is still new is retained. Both parts of this walk see the same heap, so the retained memory does not depend on changes between walks. A second walk, from the instances alone, gives all the memory reached through them; the shared memory is the difference.

The instances are all instances of the classes and their subclasses in the image, also those that the roots do not reach. Each class gets a {{gtClass:GtMemorySpaceClassRetention}} with its instances and the memory retained through them; memory retained through instances of several classes goes to the first class. The split between retained and shared memory is for all classes together.
"
Class {
	#name : #GtMemorySpaceRetention,
	#superclass : #Object,
	#instVars : [
		'estimation',
		'retainedClasses',
		'stoppingEstimate',
		'retainedEstimate',
		'reachedEstimate',
		'classRetentions'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceRetention class >> estimation: anEstimation stoppingAtInstancesOf: aCollectionOfClasses [
	"Estimate again, stopping at the instances of the classes, and compare"

	^ self new
		setEstimation: anEstimation retainedClasses: aCollectionOfClasses;
		compute;
		yourself
]

{ #category : #accessing }
GtMemorySpaceRetention >> classRetentions [
	"The memory kept by the instances of each class (GtMemorySpaceClassRetention)"

	^ classRetentions ifNil: [ #() ]
]

{ #category : #computing }
GtMemorySpaceRetention >> compute [
	"First walk the roots while stopping at the instances of the retained classes, 
	then continue the same walk from the instances: what is still new is reached only through them.
	Then walk from the instances alone, to know all the memory reached through them."

	| aDefinition anEstimator instancesOfClasses |
	aDefinition := estimation definition copyStoppingAtInstancesOf: retainedClasses.
	instancesOfClasses := retainedClasses
			collect: [ :aClass | aClass allSubInstances ].
	stoppingEstimate := GtMemorySpaceEstimate forCategories: aDefinition categories.
	retainedEstimate := GtMemorySpaceEstimate new.
	anEstimator := GtMemorySpaceEstimator new
			boundary: aDefinition newBoundary;
			expectedObjects: (aDefinition expectedObjectsFor: estimation subject);
			yourself.
	[ aDefinition
		estimateRootsOf: estimation subject
		with: anEstimator
		into: stoppingEstimate.
	anEstimator boundary: estimation definition newBoundary.
	self
		estimateInstances: instancesOfClasses
		with: anEstimator
		into: retainedEstimate ] ensure: [ anEstimator releaseVisitedObjects ].
	reachedEstimate := GtMemorySpaceEstimate new.
	anEstimator := GtMemorySpaceEstimator new
			boundary: estimation definition newBoundary;
			yourself.
	[ self
		estimateInstances: instancesOfClasses
		with: anEstimator
		into: reachedEstimate ] ensure: [ anEstimator releaseVisitedObjects ].
	classRetentions := (1 to: retainedClasses size)
			collect: [ :anIndex | 
				| aClass |
				aClass := retainedClasses at: anIndex.
				GtMemorySpaceClassRetention new
					setClass: aClass
					instances: (instancesOfClasses at: anIndex)
					retainedBytes: (retainedEstimate bytesOf: aClass) ]
]

{ #category : #private }
GtMemorySpaceRetention >> estimateInstances: aCollectionOfInstancesOfClasses with: anEstimator into: anEstimate [
	"Walk from the instances, class by class; the memory of each class goes to a category named after it"

	retainedClasses
		with: aCollectionOfInstancesOfClasses
		do: [ :aClass :theInstances | 
			theInstances
				do: [ :anInstance | 
					anEstimator
						estimate: anInstance
						inCategory: aClass
						into: anEstimate ] ]
]

{ #category : #accessing }
GtMemorySpaceRetention >> estimation [
	"The estimation that follows the instances of the retained classes"

	^ estimation
]

{ #category : #'gt - extensions' }
GtMemorySpaceRetention >> gtViewClassesFor: aView [
	<gtView>
	retainedEstimate ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Classes';
		priority: 10;
		items: [ self classRetentions ];
		column: 'Class' text: [ :each | each retainedClass name ];
		column: 'Instances'
			text: [ :each | each instancesCount ]
			width: 80;
		column: 'Their size'
			text: [ :each | each instancesBytes humanReadableIsqByteSize ]
			width: 100;
		column: 'Retained (only through them)'
			text: [ :each | each retainedBytes humanReadableIsqByteSize ]
			width: 200
]

{ #category : #'gt - extensions' }
GtMemorySpaceRetention >> gtViewSummaryFor: aView [
	<gtView>
	retainedEstimate ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ {{'Classes'.
					', ' join: (retainedClasses collect: [ :each | each name ]).
					retainedClasses}.
				{'Instances'.
					self instancesCount printString , ' ('
						, self instancesBytes humanReadableIsqByteSize , ')'.
					self classRetentions}.
				{'Reached through them'.
					self reachedBytes humanReadableIsqByteSize.
					reachedEstimate}.
				{'  only through them (retained)'.
					self retainedBytes humanReadableIsqByteSize , ' ('
						, self retainedObjectsCount printString , ' objects)'.
					retainedEstimate}.
				{'  also from other places (shared)'.
					self sharedBytes humanReadableIsqByteSize.
					self sharedBytes}.
				{'Reached from the roots without them'.
					stoppingEstimate totalBytes humanReadableIsqByteSize.
					stoppingEstimate}} ];
		column: 'Property'
			text: [ :each | each first ]
			width: 240;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #accessing }
GtMemorySpaceRetention >> instancesBytes [
	"The memory of the instances themselves"

	^ self classRetentions
		inject: 0
		into: [ :aSum :each | aSum + each instancesBytes ]
]

{ #category : #accessing }
GtMemorySpaceRetention >> instancesCount [
	^ self classRetentions
		inject: 0
		into: [ :aSum :each | aSum + each instancesCount ]
]

{ #category : #printing }
GtMemorySpaceRetention >> printOn: aStream [
	super printOn: aStream.
	retainedEstimate ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self retainedBytes humanReadableIsqByteSize;
		nextPutAll: ' retained, ';
		nextPutAll: self reachedBytes humanReadableIsqByteSize;
		nextPutAll: ' reached by ';
		nextPutAll: (', ' join: (retainedClasses collect: [ :each | each name ]));
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceRetention >> reachedBytes [
	"All the memory reached through the instances, including the instances"

	^ reachedEstimate ifNil: [ 0 ] ifNotNil: [ reachedEstimate totalBytes ]
]

{ #category : #accessing }
GtMemorySpaceRetention >> reachedEstimate [
	"All the memory reached through the instances, including the instances, per class"

	^ reachedEstimate
]

{ #category : #accessing }
GtMemorySpaceRetention >> retainedBytes [
	"The memory reached only through the instances, including the instances: 
	it would be freed without them"

	^ retainedEstimate ifNil: [ 0 ] ifNotNil: [ retainedEstimate totalBytes ]
]

{ #category : #accessing }
GtMemorySpaceRetention >> retainedClasses [
	^ retainedClasses
]

{ #category : #accessing }
GtMemorySpaceRetention >> retainedEstimate [
	"The memory reached only through the instances, including the instances, per class"

	^ retainedEstimate
]

{ #category : #accessing }
GtMemorySpaceRetention >> retainedObjectsCount [
	^ retainedEstimate
		ifNil: [ 0 ]
		ifNotNil: [ retainedEstimate totalObjectsCount ]
]

{ #category : #initialization }
GtMemorySpaceRetention >> setEstimation: anEstimation retainedClasses: aCollectionOfClasses [
	estimation := anEstimation.
	retainedClasses := aCollectionOfClasses asArray
]

{ #category : #accessing }
GtMemorySpaceRetention >> sharedBytes [
	"The memory reached through the instances that is also reached from other places"

	^ self reachedBytes - self retainedBytes
]

{ #category : #accessing }
GtMemorySpaceRetention >> stoppingEstimate [
	"What the roots reach when the walk stops at the instances of the retained classes"

	^ stoppingEstimate
]
