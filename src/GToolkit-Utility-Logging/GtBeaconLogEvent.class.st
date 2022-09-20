Class {
	#name : #GtBeaconLogEvent,
	#superclass : #GtBeaconLogBasicEvent,
	#instVars : [
		'signals'
	],
	#category : #'GToolkit-Utility-Logging'
}

{ #category : #adding }
GtBeaconLogEvent >> addSignal: aSignal [
	self signals add: aSignal
]

{ #category : #accessing }
GtBeaconLogEvent >> addSubEvent: anEvent [
	self subEvents add: anEvent
]

{ #category : #initialization }
GtBeaconLogEvent >> createDefaultEventsGroup [
	^ GtBeaconLogEventsGroup new. 
]

{ #category : #printing }
GtBeaconLogEvent >> descriptionOn: aStream [
	aStream 
		print: self timestamp;	
		<< ' announcements,';
		print: self duration
]

{ #category : #accessing }
GtBeaconLogEvent >> duration [
	^ self signalCompletedEvent timestamp - self signalStartedEvent timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> endTimestamp [
	^ self signalCompletedEvent timestamp
]

{ #category : #'gt - extensions' }
GtBeaconLogEvent >> gtViewLocalSignalsFor: aView [
	<gtView>
	
	^ aView forward
	 	title: 'Signals (local)';
	 	priority: 30;
	 	object: [ self signals ];
	 	view: #gtItemsFor:
]

{ #category : #initialization }
GtBeaconLogEvent >> initialize [ 
	super initialize.
	
	signals := GtBeaconSignalsGroup new. 
	subEvents := self createDefaultEventsGroup.
]

{ #category : #printing }
GtBeaconLogEvent >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #accessing }
GtBeaconLogEvent >> signalCompletedEvent [
	^ self signals last
]

{ #category : #accessing }
GtBeaconLogEvent >> signalStartedEvent [
	^ self signals first
]

{ #category : #acccessing }
GtBeaconLogEvent >> signals [
	^ signals
]

{ #category : #accessing }
GtBeaconLogEvent >> startTimestamp [
	^ self signalStartedEvent timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> subEvents [
	^ subEvents
]

{ #category : #accessing }
GtBeaconLogEvent >> timestamp [
	^ self startTimestamp
]
