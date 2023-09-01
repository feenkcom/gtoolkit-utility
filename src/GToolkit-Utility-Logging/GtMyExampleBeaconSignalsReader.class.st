Class {
	#name : #GtMyExampleBeaconSignalsReader,
	#superclass : #Object,
	#instVars : [
		'signalTypeIndicator'
	],
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #api }
GtMyExampleBeaconSignalsReader class >> exampleOutput [
	^ '2023-09-01T12:00:53.319685+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 1 | Bloc Main Loop
2023-09-01T12:00:53.341734+02:00 GtMyExampleBeaconStartSignal | MySignal | Start subcommand at index 1 | Bloc Main Loop
2023-09-01T12:00:53.350228+02:00 GtMyExampleBeaconStopSignal | MySignal | Start subcommand at index 1 | Bloc Main Loop
2023-09-01T12:00:53.350516+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 1 | Bloc Main Loop
2023-09-01T12:00:53.350623+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 2 | Bloc Main Loop
2023-09-01T12:00:53.453152+02:00 GtMyExampleBeaconStartSignal | MySignal | Start subcommand at index 2 | Bloc Main Loop
2023-09-01T12:00:53.555787+02:00 GtMyExampleBeaconStopSignal | MySignal | Start subcommand at index 2 | Bloc Main Loop
2023-09-01T12:00:53.555965+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 2 | Bloc Main Loop
2023-09-01T12:00:53.556038+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 3 | Bloc Main Loop
2023-09-01T12:00:53.657547+02:00 GtMyExampleBeaconStartSignal | MySignal | Start subcommand at index 3 | Bloc Main Loop
2023-09-01T12:00:53.759393+02:00 GtMyExampleBeaconStopSignal | MySignal | Start subcommand at index 3 | Bloc Main Loop
2023-09-01T12:00:53.759556+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 3 | Bloc Main Loop
2023-09-01T12:00:53.759625+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 4 | Bloc Main Loop
2023-09-01T12:00:53.77764+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 4 | Bloc Main Loop
2023-09-01T12:00:53.77781+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 5 | Bloc Main Loop
2023-09-01T12:00:53.808915+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 5 | Bloc Main Loop
2023-09-01T12:00:53.809084+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 6 | Bloc Main Loop
2023-09-01T12:00:53.873792+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 6 | Bloc Main Loop
2023-09-01T12:00:53.873866+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 7 | Bloc Main Loop
2023-09-01T12:00:53.890417+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 7 | Bloc Main Loop
2023-09-01T12:00:53.890493+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 8 | Bloc Main Loop
2023-09-01T12:00:53.915186+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 8 | Bloc Main Loop
2023-09-01T12:00:53.915251+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 9 | Bloc Main Loop
2023-09-01T12:00:53.982228+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 9 | Bloc Main Loop
2023-09-01T12:00:53.982349+02:00 GtMyExampleBeaconStartSignal | MySignal | Start at index 10 | Bloc Main Loop
2023-09-01T12:00:54.039799+02:00 GtMyExampleBeaconStopSignal | MySignal | Stop at index 10 | Bloc Main Loop
'
]

{ #category : #api }
GtMyExampleBeaconSignalsReader class >> readFrom: aStream [
	^ self new
		readFrom: aStream
]

{ #category : #api }
GtMyExampleBeaconSignalsReader class >> readFromExample [
	^ self readFrom: self exampleOutput readStream
]

{ #category : #api }
GtMyExampleBeaconSignalsReader class >> readFromFile: aFileReference [
	^ aFileReference readStreamDo: [ :aStream | 
		self new
			readFrom: aStream ]
]

{ #category : #api }
GtMyExampleBeaconSignalsReader >> createDefaultEventsGrouper [
	^ GtBeaconEventsGrouper new
]

{ #category : #initialization }
GtMyExampleBeaconSignalsReader >> initialize [
	super initialize.
	
	signalTypeIndicator := 'MySignal'
]

{ #category : #api }
GtMyExampleBeaconSignalsReader >> processSignals: aCollectionOfSignals [
	| eventsGrouper |
	eventsGrouper := self createDefaultEventsGrouper  .
	eventsGrouper processEventSignalsFor: aCollectionOfSignals.
	^ eventsGrouper
]

{ #category : #api }
GtMyExampleBeaconSignalsReader >> readFrom: aStream [
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
GtMyExampleBeaconSignalsReader >> readSignalFromLine: aLine [
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
GtMyExampleBeaconSignalsReader >> signalTypeIndicator [
	^ signalTypeIndicator
]
