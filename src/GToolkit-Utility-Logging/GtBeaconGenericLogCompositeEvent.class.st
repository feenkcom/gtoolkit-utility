Class {
	#name : #GtBeaconGenericLogCompositeEvent,
	#superclass : #GtBeaconLogCompositeEvent,
	#instVars : [
		'eventLabel'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> descriptionOn: aStream [

	aStream << eventLabel asString
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> eventLabel [
	^ eventLabel ifNil: [ 'Composite Event: ', self subEvents first eventLabel ]
]

{ #category : #accessing }
GtBeaconGenericLogCompositeEvent >> eventLabel: anObject [
	eventLabel := anObject
]
