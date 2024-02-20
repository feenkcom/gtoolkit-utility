Class {
	#name : #GtBeaconLabelledLogSignal,
	#superclass : #GtBeaconGenericLogSignal,
	#instVars : [
		'eventTypeLabel'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconLabelledLogSignal >> eventType [
	^ GtBeaconGenericLogEvent
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> eventTypeLabel [
	^ eventTypeLabel
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> eventTypeLabel: anObject [
	eventTypeLabel := anObject
]

{ #category : #printing }
GtBeaconLabelledLogSignal >> printOneLineContentsOn: aStream [
	super printOneLineContentsOn: aStream.
	
	aStream
		nextPutAll: ' | ';
		nextPutAll: (self eventTypeLabel 
			ifNil: [ '<missing type label>' ]);
		nextPutAll: ' | ';
		nextPutAll:  self processId
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> signalTypeLabel [
	^ self eventTypeLabel
]
