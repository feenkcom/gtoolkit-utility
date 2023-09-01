Class {
	#name : #GtMyExampleBeaconEventsCollector,
	#superclass : #GtBeaconEventsCollector,
	#category : #'GToolkit-Utility-Logging-Examples'
}

{ #category : #accessing }
GtMyExampleBeaconEventsCollector >> relevantSignalType [
	^ GtMyExampleBeaconStartSignal,
		GtMyExampleBeaconStopSignal.
]
