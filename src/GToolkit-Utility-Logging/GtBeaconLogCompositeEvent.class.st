Class {
	#name : #GtBeaconLogCompositeEvent,
	#superclass : #GtBeaconLogBasicEvent,
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconLogCompositeEvent >> allSignals [
	^ self subEvents allSignals
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> completedEvent [
	^ self subEvents last
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> duration [
	^ self completedEvent endTimestamp - self startedEvent startTimestamp
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> eventCompletedSignal [
	^ self completedEvent eventCompletedSignal
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> eventStartedSignal [
	^ self startedEvent eventStartedSignal
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> startTimestamp [
	^ self startedEvent timestamp
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> startedEvent [
	^ self subEvents first
]

{ #category : #accessing }
GtBeaconLogCompositeEvent >> timestamp [
	^ self startTimestamp
]
