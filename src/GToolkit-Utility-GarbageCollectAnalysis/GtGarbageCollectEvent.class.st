Class {
	#name : #GtGarbageCollectEvent,
	#superclass : #Object,
	#instVars : [
		'largestFreeChunkSize',
		'parametersDiffReport',
		'callerStackTraceRecords',
		'requestedSize'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #accessing }
GtGarbageCollectEvent >> duration [
	^self endVmParameters timestamp -  self startVmParameters timestamp
]

{ #category : #accessing }
GtGarbageCollectEvent >> endVmParameters [
	^ self parametersDiffReport targetReport
]

{ #category : #recording }
GtGarbageCollectEvent >> extractRequestedSizeFrom: aStack [
	aStack 
		detect: [ :aContext |
			aContext selector = #handleFailingBasicNew: and: [
				aContext methodClass name = #Behavior ] ]
		ifFound: [ :aContext |
			| var |
			var := aContext lookupVar: #sizeRequested.
			var isLocalVariable ifTrue: [ 
				requestedSize := var readInContext: aContext  ] ] 
]

{ #category : #views }
GtGarbageCollectEvent >> gtChangedParametersViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Changed Parameters';
		priority: 10;
		object: [ self parametersDiffReport ];
		view: #gtViewChangedParametersFor:
]

{ #category : #views }
GtGarbageCollectEvent >> gtEndVmParametersFor: aView [
	<gtView>
	^ aView forward
		title: 'End Parameters';
		priority: 16.2;
		object: [ self endVmParameters ];
		view: #gtViewVmParametersFor:
]

{ #category : #views }
GtGarbageCollectEvent >> gtStartVmParametersFor: aView [
	<gtView>
	^ aView forward
		title: 'Start Parameters';
		priority: 16.1;
		object: [ self startVmParameters ];
		view: #gtViewVmParametersFor:
]

{ #category : #views }
GtGarbageCollectEvent >> gtViewCallerStackFor: aView [
	<gtView>
	callerStackTraceRecords ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Caller Stack Record';
		priority: 15;
		items: [ callerStackTraceRecords ];
		column: 'Method' text: [ :each | each methodDescription ];
		column: 'Program Counter' text: [ :each | each programCounter ] width: 120
]

{ #category : #accessing }
GtGarbageCollectEvent >> largestFreeChunkSize [
	^ largestFreeChunkSize
]

{ #category : #accessing }
GtGarbageCollectEvent >> largestFreeChunkSize: anInteger [
	largestFreeChunkSize := anInteger
]

{ #category : #accessing }
GtGarbageCollectEvent >> largestFreeChunkSizeDescription [
	^ self largestFreeChunkSize humanReadableSISizeString
]

{ #category : #recording }
GtGarbageCollectEvent >> numberOfContextsToExtract [
	^ 30
]

{ #category : #accessing }
GtGarbageCollectEvent >> parametersDiffReport [
	^ parametersDiffReport
]

{ #category : #printing }
GtGarbageCollectEvent >> printOn: aStream [ 
	super printOn: aStream .
	aStream parenthesize: [
		aStream 
			<< self startTime asTime print24;
			<< '; ';
			<< self duration gtShortPrintString;
			<< '; freed: ';
			<< self reducedOldSpaceSizeDescription; 
			<< ' [largest chunk: ';
			<< self largestFreeChunkSizeDescription;
			<< ']' ]
]

{ #category : #recording }
GtGarbageCollectEvent >> recordCallerStackTrace [
	| callerStackTrace  |
	callerStackTrace := thisContext stackOfSize: self numberOfContextsToExtract.
	
	callerStackTraceRecords := callerStackTrace
			collect: [ :each | GtBareRecordedStackFrameCall forContext: each ].

	self extractRequestedSizeFrom: callerStackTrace
]

{ #category : #recording }
GtGarbageCollectEvent >> recordEndReport [
	parametersDiffReport recordTargetReport.
	self recordCallerStackTrace.
]

{ #category : #recording }
GtGarbageCollectEvent >> recordStartReport [
	parametersDiffReport := GtVmAllParametersDiffReport new.
	parametersDiffReport recordSourceReport
]

{ #category : #accessing }
GtGarbageCollectEvent >> reducedOldSpaceSizeDescription [
	^ self parametersDiffReport reducedOldSpaceSize 
		humanReadableSISizeString
]

{ #category : #accessing }
GtGarbageCollectEvent >> requestedSizeDescription [
	^ requestedSize
		ifNil: [ '-' ]
		ifNotNil: [ :anInteger | anInteger humanReadableSISizeString ]
]

{ #category : #accessing }
GtGarbageCollectEvent >> sourceDescription [
	^ requestedSize 
		ifNil: ['<unknowm>'] 
		ifNotNil: [ :anInteger |
			'BasicNew [', self requestedSizeDescription, ']' ]
]

{ #category : #accessing }
GtGarbageCollectEvent >> startTime [
	^ self startVmParameters timestamp
]

{ #category : #accessing }
GtGarbageCollectEvent >> startVmParameters [
	^ self parametersDiffReport sourceReport
]
