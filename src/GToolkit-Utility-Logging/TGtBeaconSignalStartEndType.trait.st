Trait {
	#name : #TGtBeaconSignalStartEndType,
	#instVars : [
		'eventType'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #testing }
TGtBeaconSignalStartEndType >> isEndSignalType [
	^ eventType = #endSignal
]

{ #category : #testing }
TGtBeaconSignalStartEndType >> isStartSignalType [
	^ eventType = #startSignal
]

{ #category : #configuring }
TGtBeaconSignalStartEndType >> markAsEndSignal [
	eventType := #endSignal
]

{ #category : #configuring }
TGtBeaconSignalStartEndType >> markAsStartSignal [
	eventType := #startSignal
]
