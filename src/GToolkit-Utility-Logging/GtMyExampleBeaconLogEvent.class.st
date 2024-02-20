Class {
	#name : #GtMyExampleBeaconLogEvent,
	#superclass : #GtBeaconLogEvent,
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #accessing }
GtMyExampleBeaconLogEvent class >> eventLabel [
	^ 'My Example Event'
]

{ #category : #accessing }
GtMyExampleBeaconLogEvent >> descriptionOn: aStream [
	aStream << self eventStartedSignal signalLabel
]
