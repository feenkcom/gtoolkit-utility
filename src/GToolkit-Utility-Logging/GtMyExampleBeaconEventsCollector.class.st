Class {
	#name : #GtMyExampleBeaconEventsCollector,
	#superclass : #GtBeaconEventsCollector,
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #accessing }
GtMyExampleBeaconEventsCollector >> defaultSignalType [
	^ GtMyExampleBeaconStartSignal,
		GtMyExampleBeaconStopSignal.
]

{ #category : #accessing }
GtMyExampleBeaconEventsCollector >> relevantSignalType [
	^ GtMyExampleBeaconStartSignal,
		GtMyExampleBeaconStopSignal.
]
