Class {
	#name : #GtBeaconGenericLogCompositeEvent,
	#superclass : #GtBeaconLogBasicEvent,
	#instVars : [
		'eventLabel'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> allSignals [
	^ self subEvents collect: #allSignals 
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> descriptionOn: aStream [

	aStream << eventLabel asString
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> duration [

	^ self endTimestamp - self startTimestamp
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> endTimestamp [
	self subEvents ifEmpty: [ ^ nil ].
	^ self subEvents last endTimestamp
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> eventLabel [
	^ eventLabel ifNil: [ 'Composite Event: ', self subEvents first eventLabel ]
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> eventLabel: anObject [
	eventLabel := anObject
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> startTimestamp [
	self subEvents ifEmpty: [ ^ nil ].
	^ self subEvents first startTimestamp
]
