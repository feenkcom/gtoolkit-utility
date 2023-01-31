Class {
	#name : #GtRlReleaserSignalsLogReader,
	#superclass : #Object,
	#instVars : [
		'signalTypeIndicator'
	],
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #api }
GtRlReleaserSignalsLogReader class >> readFrom: aStream [
	^ self new
		readFrom: aStream
]

{ #category : #api }
GtRlReleaserSignalsLogReader >> createDefaultEventsGrouper [
	^ GtRlReleaserEventsGrouper new
]

{ #category : #initialization }
GtRlReleaserSignalsLogReader >> initialize [
	super initialize.
	
	signalTypeIndicator := 'ReleaserSignal'
]

{ #category : #api }
GtRlReleaserSignalsLogReader >> processSignals: aCollectionOfSignals [
	| eventsGrouper |
	eventsGrouper := self createDefaultEventsGrouper  .
	eventsGrouper processEventSignalsFor: aCollectionOfSignals.
	^ eventsGrouper
]

{ #category : #api }
GtRlReleaserSignalsLogReader >> readFrom: aStream [
	| newSignals typeIndicator |
	newSignals := OrderedCollection new.
	typeIndicator := '| ', self signalTypeIndicator ,' |'.
	
	aStream contents linesDo: [ :aLine |
		(aLine includesSubstring: typeIndicator) ifTrue: [
			| newSignal |
			newSignal := self readSignalFromLine: aLine.
			newSignals add: newSignal ] ].
	
	^ self processSignals: newSignals
]

{ #category : #accessing }
GtRlReleaserSignalsLogReader >> readSignalFromLine: aLine [
	| timestampString signalClassName parts signalClass signal |
	
	parts := aLine splitOn: ' | '.
	
	timestampString := parts first copyUpTo: Character space.
	signalClassName := (parts first 
		copyFrom: timestampString size + 1 
		to: parts first size) trimBoth.
	
	signalClass := signalClassName asClass.
	signal := signalClass new.
	signal 
		initializeFromTimestamp: timestampString asDateAndTime 
		andData: parts.
	^ signal
]

{ #category : #accessing }
GtRlReleaserSignalsLogReader >> signalTypeIndicator [
	^ signalTypeIndicator
]
