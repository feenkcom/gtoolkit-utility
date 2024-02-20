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
	^ GtBeaconLogEvent
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> eventTypeLabel [
	^ eventTypeLabel
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> eventTypeLabel: anObject [
	eventTypeLabel := anObject
]

{ #category : #accessing }
GtBeaconLabelledLogSignal >> signalTypeLabel [
	^ self eventTypeLabel
]
