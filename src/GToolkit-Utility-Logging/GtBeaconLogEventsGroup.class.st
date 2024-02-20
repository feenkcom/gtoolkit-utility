Class {
	#name : #GtBeaconLogEventsGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #adding }
GtBeaconLogEventsGroup >> addAll: aCollection [
	self items addAll: aCollection
]

{ #category : #accessing }
GtBeaconLogEventsGroup >> allEvents [

	^ items flatCollect: [ :each |
		each allEvents ].
]

{ #category : #accessing }
GtBeaconLogEventsGroup >> allSignals [
	^ GtBeaconSignalsGroup 
		withAll: (self items flatCollect: #allSignals)
]

{ #category : #ui }
GtBeaconLogEventsGroup >> executionTimelineChartItems [

	^ self allEvents collect: [ :each | | item |
		item := GtRrExecutionChartDataItem new
			startTime: each startTimestamp;
			endTime: each endTimestamp;
			label: each description;
			appendDurationToLabel.
		item propertyAt: #source put: each.
		item ]
]

{ #category : #'gt - extensions' }
GtBeaconLogEventsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Events';
		priority: 10;
		items: [ self ];
		children: #subEvents;
		column: 'Event Type' text: [ :anEvent | anEvent class eventLabel ];
		column: 'Timestamp' text: #timestamp;
		column: 'Duration' 
			text: [ :anEvent | anEvent duration ]
]

{ #category : #ui }
GtBeaconLogEventsGroup >> gtViewExecutionTimelineListFor: aView [
	<gtView>
	^self executionTimelineChartItems
		ifEmpty: [aView empty]
		ifNotEmpty: [ :currentTimelineData |
			aView explicit
				title: 'Job Execution Timeline';
				priority: 30;
				stencil: 
						[(GtRrExecutionHorizontalChartStencil new)
							executions: currentTimelineData;
							colorComputation: [ :anItem |
								(Color r: 92 g: 204 b: 231 range: 255) alpha: 0.8 ] ] ]
]

{ #category : #enumerating }
GtBeaconLogEventsGroup >> inject: thisValue into: binaryBlock [
	^ self items 
		inject: thisValue into: binaryBlock
]

{ #category : #'math functions' }
GtBeaconLogEventsGroup >> sumDurations: aBlock [
	^ self  
		inject: 0 seconds 
		into: [ :total  :anEventsGrouper | 
			total + (aBlock value: anEventsGrouper) ]
]

{ #category : #'math functions' }
GtBeaconLogEventsGroup >> sumNumbers: aBlock [
	^ self items sumNumbers: aBlock
]

{ #category : #accessing }
GtBeaconLogEventsGroup >> totalDuration [
	
	^ self
		sumDurations: [ :anEvent | anEvent duration ]
]
