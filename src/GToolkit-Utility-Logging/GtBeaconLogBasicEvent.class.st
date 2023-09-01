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
GtBeaconLogBasicEvent >> allSignals [
	^ self subclassResponsibility 
]

{ #category : #initialization }
GtBeaconLogBasicEvent >> createDefaultEventsGroup [
	^ GtBeaconLogEventsGroup new. 
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

{ #category : #'gt - extensions' }
GtBeaconLogBasicEvent >> gtViewAllSignalsFor: aView [
	<gtView>
	
	^ aView forward
	 	title: 'Signals (all)';
	 	priority: 33;
	 	object: [ self allSignals ];
	 	view: #gtItemsFor:
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

{ #category : #accessing }
GtBeaconLogBasicEvent >> startTimestamp [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> subEvents [
	^ subEvents
]

{ #category : #accessing }
GtBeaconLogBasicEvent >> timestamp [
	^ self startTimestamp
]
