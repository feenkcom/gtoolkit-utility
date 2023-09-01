Class {
	#name : #GtBeaconLogEvent,
	#superclass : #GtBeaconLogBasicEvent,
	#instVars : [
		'signals'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconLogEvent class >> eventLabel [
	^ 'Beacon Event'
]

{ #category : #adding }
GtBeaconLogEvent >> addSignal: aSignal [
	self signals add: aSignal
]

{ #category : #accessing }
GtBeaconLogEvent >> allSignals [

	^ GtBeaconSignalsGroup new 
		add: self eventStartedSignal;
		addAll: self subEvents allSignals;
		add: self eventCompletedSignal;
		yourself
]

{ #category : #accessing }
GtBeaconLogEvent >> duration [
	^ self eventCompletedSignal timestamp - self eventStartedSignal timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> endTimestamp [
	^ self eventCompletedSignal timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> eventCompletedSignal [
	^ self signals last
]

{ #category : #accessing }
GtBeaconLogEvent >> eventStartedSignal [
	^ self signals first
]

{ #category : #'gt - extensions' }
GtBeaconLogEvent >> gtViewLocalSignalsFor: aView [
	<gtView>
	
	^ aView forward
	 	title: 'Signals';
	 	priority: 30;
	 	object: [ self signals ];
	 	view: #gtItemsFor:
]

{ #category : #initialization }
GtBeaconLogEvent >> initialize [ 
	super initialize.
	
	signals := GtBeaconSignalsGroup new. 
]

{ #category : #acccessing }
GtBeaconLogEvent >> signals [
	^ signals
]

{ #category : #accessing }
GtBeaconLogEvent >> startTimestamp [
	^ self eventStartedSignal timestamp
]
