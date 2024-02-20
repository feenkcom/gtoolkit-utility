Class {
	#name : #GtBeaconGenericLogSignal,
	#superclass : #BeaconSignal,
	#traits : 'TGtBeaconSignalStartEndType',
	#classTraits : 'TGtBeaconSignalStartEndType classTrait',
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
GtBeaconGenericLogSignal >> signalLabel [
	^ signalLabel
]

{ #category : #accessing }
GtBeaconGenericLogSignal >> signalLabel: anObject [
	signalLabel := anObject
]

{ #category : #accessing }
GtBeaconGenericLogSignal >> signalPayload [
	^ signalPayload
]

{ #category : #accessing }
GtBeaconGenericLogSignal >> signalPayload: aPayload [
	signalPayload := aPayload
]
