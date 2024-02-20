Class {
	#name : #GtMyExampleBeaconLogEvent,
	#superclass : #GtBeaconLogEvent,
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #accessing }
GtMyExampleBeaconLogEvent class >> eventLabel [
	^ 'My Example Event'
]

{ #category : #printing }
GtMyExampleBeaconLogEvent >> shortDescriptionOn: aStream [
	aStream nextPutAll: self signals first signalLabel
]
