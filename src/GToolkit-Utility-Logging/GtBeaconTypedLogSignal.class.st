Class {
	#name : #GtBeaconTypedLogSignal,
	#superclass : #GtBeaconGenericLogSignal,
	#instVars : [
		'eventTypeName'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconTypedLogSignal >> eventType [
	^ eventTypeName asClass 
]

{ #category : #accessing }
GtBeaconTypedLogSignal >> eventTypeName [
	^ eventTypeName
]

{ #category : #accessing }
GtBeaconTypedLogSignal >> eventTypeName: anEventName [
	eventTypeName := anEventName
]
