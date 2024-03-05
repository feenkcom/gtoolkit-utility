Class {
	#name : #GtBeaconLogBasicEvent,
	#superclass : #Object,
	#instVars : [
		'subEvents'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconLogBasicEvent class >> needComposition [
	^ false
]

{ #category : #adding }
GtBeaconLogBasicEvent >> addSubEvent: anEvent [
	self subEvents add: anEvent
]

{ #category : #adding }
GtBeaconLogBasicEvent >> addSubEvents: aCollection [
	aCollection do: [ :each |
		self addSubEvent: each ]
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> allEvents [

	^ Array streamContents: [ :stream |
		self allEventsOn: stream ]
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> allEventsOn: stream [

	stream nextPut: self.
	subEvents do: [ :each |
		each allEventsOn: stream ].
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> allSignals [
	^ self subclassResponsibility 
]

{ #category : #initialization }
GtBeaconLogBasicEvent >> createDefaultEventsGroup [
	^ GtBeaconLogEventsGroup new. 
]

{ #category : #printing }
GtBeaconLogBasicEvent >> description [

	^ String streamContents: [ :stream |
		self descriptionOn: stream ]
]

{ #category : #printing }
GtBeaconLogBasicEvent >> descriptionOn: aStream [
	aStream 
		print: self timestamp;	
		<< ', ';
		print: self duration
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> duration [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> eventLabel [
	self subclassResponsibility
]

{ #category : #ui }
GtBeaconLogBasicEvent >> executionTimelineChartItems [

	^ self allEvents collect: [ :each | | item |
		item := GtRrExecutionChartDataItem new
			identifier: each;
			startTime: each startTimestamp;
			endTime: each endTimestamp;
			label: each description;
			appendDurationToLabel.
		item ]
]

{ #category : #ui }
GtBeaconLogBasicEvent >> executionTimelineLeafChartItems [

	^ (self allEvents select: [ :anEvent | anEvent subEvents isEmpty ]) 
		collect: [ :each | | item |
		item := GtRrExecutionChartDataItem new
			identifier: each;
			startTime: each startTimestamp;
			endTime: each endTimestamp;
			label: each description;
			appendDurationToLabel.
		item ]
]

{ #category : #'gt - extensions' }
GtBeaconLogBasicEvent >> gtViewAllSignalsFor: aView [
	<gtView>
	
	^ aView forward
	 	title: 'Signals (all)';
	 	priority: 33;
	 	object: [ self allSignals ];
	 	view: #gtItemsFor:
]

{ #category : #ui }
GtBeaconLogBasicEvent >> gtViewExecutionLeafsTimelineListFor: aView [
	"<gtView>"
	^self executionTimelineLeafChartItems
		ifEmpty: [aView empty]
		ifNotEmpty: [ :currentTimelineData |
			aView explicit
				title: 'Job Execution Timeline';
				priority: 32;
				stencil: 
						[(GtRrExecutionHorizontalChartStencil new)
							executions: currentTimelineData;
							configureWithSmallerDetails;
							colorComputation: [ :anItem |
								(Color r: 92 g: 204 b: 231 range: 255) alpha: 0.8 ] ] ]
]

{ #category : #ui }
GtBeaconLogBasicEvent >> gtViewExecutionTimelineListFor: aView [
	<gtView>
	^self executionTimelineChartItems
		ifEmpty: [aView empty]
		ifNotEmpty: [ :currentTimelineData |
			aView explicit
				title: 'Job Execution Timeline';
				priority: 32;
				stencil: 
						[(GtRrExecutionHorizontalChartStencil new)
							executions: currentTimelineData;
							colorComputation: [ :anItem |
								(Color r: 92 g: 204 b: 231 range: 255) alpha: 0.8 ] ;
							selectionTransformation: [ :anItem |
								anItem identifier ] ] ]
]

{ #category : #ui }
GtBeaconLogBasicEvent >> gtViewSubEventTimelineListFor: aView [
	<gtView>

	^self subEventTimelineChartItems
		ifEmpty: [aView empty]
		ifNotEmpty: [ :currentTimelineData |
			aView explicit
				title: 'Sub Event Timeline';
				priority: 30;
				stencil: 
						[(GtRrExecutionHorizontalChartStencil new)
							executions: currentTimelineData;
							colorComputation: [ :anItem |
								(Color r: 92 g: 204 b: 231 range: 255) alpha: 0.8 ];
							selectionTransformation: [ :anItem | anItem identifier] ] ]
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> gtViewSubEventsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Sub events';
		priority: 10;
		object: [ self subEvents ];
		view: #gtItemsFor:
]

{ #category : #initialization }
GtBeaconLogBasicEvent >> initialize [ 
	super initialize.
	
	subEvents := self createDefaultEventsGroup.
]

{ #category : #printing }
GtBeaconLogBasicEvent >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #printing }
GtBeaconLogBasicEvent >> shortDescription [

	^ String streamContents: [ :stream |
		self shortDescriptionOn: stream ]
]

{ #category : #printing }
GtBeaconLogBasicEvent >> shortDescriptionOn: aStream [
	self descriptionOn: aStream
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> startTimestamp [
	^ self subclassResponsibility 
]

{ #category : #ui }
GtBeaconLogBasicEvent >> subEventTimelineChartItems [

	^ self subEvents collect: [ :each | | item |
		item := GtRrExecutionChartDataItem new
			identifier: each;
			startTime: each startTimestamp;
			endTime: each endTimestamp;
			label: each description;
			appendDurationToLabel.
		item ]
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> subEvents [
	^ subEvents
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> subEvents: anEventsGroup [
	"Overwrite the subEvents.
	This is only used for post-processing of events."

	subEvents := anEventsGroup
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> timestamp [
	^ self startTimestamp
]
