Class {
	#name : #GtBeaconEventsCollector,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'logger',
		'eventsGrouper'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconEventsCollector class >> cleanUp [
	defaultInstance ifNotNil: [ 
		defaultInstance stop.
		defaultInstance := nil ]
]

{ #category : #accessing }
GtBeaconEventsCollector class >> defaultInstance [
	^ defaultInstance ifNil: [ 
		defaultInstance := self new ]
]

{ #category : #actions }
GtBeaconEventsCollector class >> reset [
	self defaultInstance reset
]

{ #category : #actions }
GtBeaconEventsCollector class >> start [
	^ self defaultInstance start
]

{ #category : #actions }
GtBeaconEventsCollector class >> stop [
	^ self defaultInstance stop
]

{ #category : #callbacks }
GtBeaconEventsCollector >> actOnRelevantSignalFor: aSignal [
	mutex critical: [
		eventsGrouper processEventSignalFor: aSignal ]
]

{ #category : #initialization }
GtBeaconEventsCollector >> createDefaultEventsGrouper [
	^ GtBeaconEventsGrouper new
]

{ #category : #initialization }
GtBeaconEventsCollector >> defaultSignalType [
	^ self relevantSignalType
]

{ #category : #'gt - extensions' }
GtBeaconEventsCollector >> gtOverviewFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Overview';
		priority: 5;
		object:  [ eventsGrouper ];
		view: #gtOverviewFor:
]

{ #category : #'gt - extensions' }
GtBeaconEventsCollector >> gtViewBeaconSignalsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Beacon signals';
		priority: 25;
		object: [ logger ];
		view: #gtRecordingsFor:
]

{ #category : #'gt - extensions' }
GtBeaconEventsCollector >> gtViewRootEventsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Events';
		priority: 15;
		object: [ eventsGrouper ];
		view: #gtViewRootEventsFor:
]

{ #category : #initialization }
GtBeaconEventsCollector >> initialize [
	super initialize.
	
	mutex := Mutex new.
	
	eventsGrouper := self createDefaultEventsGrouper.
	eventsGrouper notifyUpdates.
	
	logger := MemoryLogger new
		initializeInterestingSubscriptionsWith: self relevantSignalType.
	logger announcer
		when: self relevantSignalType 
		send: #actOnRelevantSignalFor: 
		to: self
]

{ #category : #initialization }
GtBeaconEventsCollector >> relevantSignalType [
	^ BeaconSignal
]

{ #category : #actions }
GtBeaconEventsCollector >> reset [
	mutex critical: [
		eventsGrouper reset ].
	logger reset
]

{ #category : #actions }
GtBeaconEventsCollector >> start [
	logger start
]

{ #category : #actions }
GtBeaconEventsCollector >> stop [
	logger stop
]
