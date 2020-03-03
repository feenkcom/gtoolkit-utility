Class {
	#name : #GtRecordingSpaceListener,
	#superclass : #Object,
	#instVars : [
		'pulseListener',
		'eventHandlers',
		'space',
		'spaceEvents'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #ui }
GtRecordingSpaceListener >> gtViewSpaceEventIn: aView [
	<gtView>
	^ aView columnedList
		title: 'Space events';
		items: [ spaceEvents ];
		column: 'Type' format: [ :aSpaceEvent | aSpaceEvent blocEvent class name ];
		column: 'Start' format: [ :aSpaceEvent | aSpaceEvent blocEvent start asTime ];
		column: 'Duration' format: [ :aSpaceEvent | aSpaceEvent duration ]
]

{ #category : #initialize }
GtRecordingSpaceListener >> initialize [
	super initialize.
	eventHandlers := OrderedCollection new.
	spaceEvents := OrderedCollection new.
]

{ #category : #initialize }
GtRecordingSpaceListener >> listenForEvent: eventType inSpace: aSpace [
	| eventHandler |
	eventHandler := (BlEventHandler on: eventType do: [ :evt | 
		self recordEvent: evt ]).
	eventHandlers add: eventHandler.
	aSpace eventDispatcher addEventHandler: eventHandler.
]

{ #category : #accessing }
GtRecordingSpaceListener >> pulseListener: aPulseListener [
	pulseListener := aPulseListener
]

{ #category : #recording }
GtRecordingSpaceListener >> recordEvent: aBlocSpaceEvent [
	| spaceEvent |
	spaceEvent := GtRecordingSpaceFrameEvent new
		space: space;
		blocEvent: aBlocSpaceEvent.
	pulseListener hasPulseEvents ifTrue: [
		"Only attach the space event to a pulsse if there is already a pule event recorded."
		spaceEvent pulseEvent: pulseListener currentPulseEvent.
		pulseListener currentPulseEvent recordSpaceEvent: spaceEvent ].
	spaceEvents add: spaceEvent.
]

{ #category : #initialize }
GtRecordingSpaceListener >> registerSpace: aSpace [
	self assert: [ space isNil ]  description: 'Already listening for events in a space.'.
	space := aSpace.
	self listenForEvent: BlSpaceRenderEndEvent inSpace: aSpace.
	self listenForEvent: BlSpaceEventsProcessedEvent inSpace: aSpace.
	self listenForEvent: BlSpaceLayoutEndEvent inSpace: aSpace.
	self listenForEvent: BlSpaceTasksEndEvent inSpace: aSpace.
]

{ #category : #accessing }
GtRecordingSpaceListener >> space [
	^ space
]

{ #category : #initialize }
GtRecordingSpaceListener >> unregister [
	eventHandlers do: [ :anEventHandler |
		space eventDispatcher removeEventHandler: anEventHandler ].
	space := nil.
]
