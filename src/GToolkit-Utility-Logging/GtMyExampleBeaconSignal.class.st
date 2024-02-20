Class {
	#name : #GtMyExampleBeaconSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'message'
	],
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #accessing }
GtMyExampleBeaconSignal class >> emit: aString [
	^ self new 
		message: aString;
		emit
]

{ #category : #accessing }
GtMyExampleBeaconSignal class >> eventType [
	^ GtMyExampleBeaconLogEvent
]

{ #category : #'as yet unclassified' }
GtMyExampleBeaconSignal >> initializeFromTimestamp: aDateAndTime andData: aCollection [ 
	timestamp := aDateAndTime.
	message := aCollection third.
]

{ #category : #accessing }
GtMyExampleBeaconSignal >> isEndSignalType [
	^ false
]

{ #category : #accessing }
GtMyExampleBeaconSignal >> isStartSignalType [
	^ false
]

{ #category : #accessing }
GtMyExampleBeaconSignal >> message: anObject [
	message := anObject
]

{ #category : #accessing }
GtMyExampleBeaconSignal >> printOneLineContentsOn: stream [
	stream 
		nextPut: $|; space;
		nextPutAll: message;
		space; nextPut: $|; space;
		nextPutAll: self processId
]

{ #category : #accessing }
GtMyExampleBeaconSignal >> signalLabel [
	^ message
]
