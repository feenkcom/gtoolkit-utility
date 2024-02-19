Class {
	#name : #GtBeaconGenericLogSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'signalPayload',
		'signalLabel'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconGenericLogSignal >> eventType [
	self subclassResponsibility
]

{ #category : #accessing }
GtBeaconGenericLogSignal >> signalPayload [
	^ signalPayload
]

{ #category : #accessing }
GtBeaconGenericLogSignal >> signalPayload: aPayload [
	signalPayload := aPayload
]
