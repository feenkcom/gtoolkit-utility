Class {
	#name : #GtGarbageCollectsRecorder,
	#superclass : #Object,
	#instVars : [
		'events',
		'isEnabled',
		'initialVmParametersReport'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #accessing }
GtGarbageCollectsRecorder class >> cleanUpDefaultInstance [
	defaultInstance ifNotNil: [ :aRecorder |
		aRecorder  defaultInstance ].
	defaultInstance := nil
]

{ #category : #accessing }
GtGarbageCollectsRecorder class >> defaultInstance [
	^defaultInstance ifNil: [
		defaultInstance := self new ]
]

{ #category : #accessing }
GtGarbageCollectsRecorder class >> defaultInstance: anObject [
	defaultInstance := anObject
]

{ #category : #accessing }
GtGarbageCollectsRecorder class >> isDefaultActive [ 
	^defaultInstance notNil and: [
		defaultInstance isActive ]
]

{ #category : #actions }
GtGarbageCollectsRecorder >> activate [ 
	self install.
	self startRecording.
]

{ #category : #actions }
GtGarbageCollectsRecorder >> beDefault [
	self class defaultInstance: self
]

{ #category : #updating }
GtGarbageCollectsRecorder >> clearEvents [
	events := WaitfreeQueue new
]

{ #category : #accessing }
GtGarbageCollectsRecorder >> createReport [
	^ GtGarbageCollectsReport new
		overallParametersDiffReport: (GtVmAllParametersDiffReport new 
			sourceReport:  initialVmParametersReport;
			targetReport: GtVmAllParametersReport recordNewReport);
		events: (GtGarbageCollectEventsGroup withAll: ((events itemArray
			reject: [ :each | each isZombie ])
				collect: [ :item | item object ])) 
]

{ #category : #actions }
GtGarbageCollectsRecorder >> deactivate [
	self uninstall.
	self disable.
]

{ #category : #actions }
GtGarbageCollectsRecorder >> disable [
	isEnabled := false
]

{ #category : #actions }
GtGarbageCollectsRecorder >> enable [
	isEnabled := true
]

{ #category : #initialization }
GtGarbageCollectsRecorder >> initialize [ 
	super initialize.
	
	isEnabled := false.
	self reset.
]

{ #category : #updating }
GtGarbageCollectsRecorder >> install [
	self 
		forPharo12AndNewer: [
			SmalltalkImage compile: 'garbageCollect
	^GtGarbageCollectsRecorder defaultInstance
		recordDuring: [ self primitiveGarbageCollect ] '
				classified: 'gt-patch'] 
		forPharo11: [
			SmalltalkImage compile: 'garbageCollect
	^GtGarbageCollectsRecorder defaultInstance
		recordDuring: [ 
			Object flushDependents.
			self primitiveGarbageCollect ] '
				classified: 'memory space']
]

{ #category : #accessing }
GtGarbageCollectsRecorder >> isActive [ 
	^isEnabled ifNil: [ false ]
]

{ #category : #testing }
GtGarbageCollectsRecorder >> isEnabled [
	^ isEnabled
]

{ #category : #actions }
GtGarbageCollectsRecorder >> recordDuring: aBlockDoingGc [
	| previousActiveStatus newEvent result |
	self isEnabled ifFalse: [
		^ aBlockDoingGc value.].
	
	previousActiveStatus := isEnabled.
	isEnabled := false.
	
	newEvent := GtGarbageCollectEvent new.
	newEvent recordStartReport.
	result := aBlockDoingGc value.
	newEvent largestFreeChunkSize: result.
	newEvent recordEndReport.
	
	events nextPut: newEvent.
	
	isEnabled := previousActiveStatus.
	^result
]

{ #category : #updating }
GtGarbageCollectsRecorder >> reset [
	self clearEvents.
	self updateInitialParameters.
]

{ #category : #actions }
GtGarbageCollectsRecorder >> startRecording [
	self reset.
	self enable.
]

{ #category : #updating }
GtGarbageCollectsRecorder >> uninstall [
	self 
		forPharo12AndNewer: [
			SmalltalkImage compile: 'garbageCollect
	"Primitive. Reclaims all garbage and answers the size of the largest free chunk in old space."

	^ self primitiveGarbageCollect'
				classified: 'memory space'] 
		forPharo11: [
			SmalltalkImage compile: 'garbageCollect
	"Primitive. Reclaims all garbage and answers the number of bytes of available space."
	Object flushDependents.
	^self primitiveGarbageCollect'
				classified: 'memory space']
]

{ #category : #actions }
GtGarbageCollectsRecorder >> updateInitialParameters [
	initialVmParametersReport := GtVmAllParametersReport recordNewReport.
]
