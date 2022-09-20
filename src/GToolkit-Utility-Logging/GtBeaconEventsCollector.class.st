Class {
	#name : #GtBeaconEventsCollector,
	#superclass : #Object,
	#instVars : [
		'logger',
		'eventsGrouper'
	],
	#category : #'GToolkit-Utility-Logging'
}

{ #category : #callbacks }
GtBeaconEventsCollector >> actOnRelevantSignalFor: aSignal [
	eventsGrouper processEventSignalFor: aSignal
]

{ #category : #initialization }
GtBeaconEventsCollector >> createDefaultEventsGrouper [
	^ GtBeaconEventsGrouper new
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
		title: 'Beacon Signals';
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
GtBeaconEventsCollector >> start [
	logger start
]

{ #category : #accessing }
GtBeaconEventsCollector >> stop [
	logger stop
]
