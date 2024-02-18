Class {
	#name : #GtFlatEventsGrouper,
	#superclass : #Object,
	#instVars : [
		'startedSignalTypes',
		'events',
		'eventGroup',
		'strictMode'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtFlatEventsGrouper >> events [

	^ events
]

{ #category : #accessing }
GtFlatEventsGrouper >> eventsGroup [

	^ eventGroup
]

{ #category : #initialization }
GtFlatEventsGrouper >> initialize [

	super initialize.
	startedSignalTypes := Dictionary new.
	events := OrderedCollection new.
	strictMode := true.
]

{ #category : #actions }
GtFlatEventsGrouper >> processEventSignalFor: aSignal [
	| key |

	key := aSignal signalTypeLabel ", '-', aSignal processId asString".
	aSignal isStartSignalType ifTrue: [ 
		| newEvent |
		newEvent := aSignal class eventType new.
		newEvent addSignal: aSignal.
		(startedSignalTypes 
			at: key
			ifAbsentPut: [ OrderedCollection new ])
				add: newEvent.
		^ self ].
		
	aSignal isEndSignalType ifTrue: 
		[ | candidateEvents completedEvent |
		candidateEvents := startedSignalTypes at: key ifAbsent: [ ].
		(strictMode not and: [ candidateEvents isNil ]) ifTrue:
			[ ^ self ].
		completedEvent := aSignal matchingSignalFrom: candidateEvents.
		completedEvent ifNil:
			[ self error: 'Unable to find matching event' ].
		completedEvent addSignal: aSignal.
		events add: completedEvent.
		candidateEvents remove: completedEvent.
		candidateEvents ifEmpty: [ startedSignalTypes removeKey: key ] ].
]

{ #category : #actions }
GtFlatEventsGrouper >> processEventSignalsFor: aCollectionfSignals [

	aCollectionfSignals do: [ :aSignal |
		self processEventSignalFor: aSignal ].
	strictMode ifTrue:
		[ self assert: startedSignalTypes isEmpty ].
	events := events sorted: #startTimestamp ascending.
	eventGroup := GtBeaconLogEventsGroup withAll: events.
]

{ #category : #accessing }
GtFlatEventsGrouper >> strictMode [
	^ strictMode
]

{ #category : #accessing }
GtFlatEventsGrouper >> strictMode: anObject [
	strictMode := anObject
]
