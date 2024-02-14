Class {
	#name : #GtBeaconSignalsEmitter,
	#superclass : #Object,
	#instVars : [
		'shouldEmitSignals'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #configuring }
GtBeaconSignalsEmitter >> disableEmitting [
	shouldEmitSignals := false
]

{ #category : #configuring }
GtBeaconSignalsEmitter >> enableEmitting [
	shouldEmitSignals := true
]

{ #category : #logging }
GtBeaconSignalsEmitter >> isEmittingEnabled [
	^ shouldEmitSignals ifNil: [ true ]
]

{ #category : #logging }
GtBeaconSignalsEmitter >> whenEnabled: aBlock [
	self isEmittingEnabled ifTrue: [
		aBlock value ] 
]
