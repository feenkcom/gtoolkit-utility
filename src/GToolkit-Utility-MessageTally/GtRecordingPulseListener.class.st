"
pulseListener := GtRecordingPulseListener new.
pulseListener 
	registerPulseLoop;
	registerSpaceListenerFor: BlUniverse default spaceManager spaces first.
pulseListener unregisterAll.
"
Class {
	#name : #GtRecordingPulseListener,
	#superclass : #Object,
	#instVars : [
		'pulseEvents',
		'spaceListeners'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #accessing }
GtRecordingPulseListener >> clear [
	"Do nothing. This will be called in case the universe stops."
]

{ #category : #accessing }
GtRecordingPulseListener >> currentPulseEvent [
	^ self pulseEvents last
]

{ #category : #private }
GtRecordingPulseListener >> eventsGroupedByDuration: aDuration [
	| groupedEvents currentTime currentGroup |
	groupedEvents := OrderedCollection new.
	self pulseEvents ifEmpty: [ ^ groupedEvents ].
	currentTime := self pulseEvents first timestamp truncated.
	currentGroup := OrderedCollection new.
	self pulseEvents do: [ :anEvent |
		| eventTime |
		eventTime := anEvent timestamp truncated.
		[eventTime < (currentTime + aDuration)]
			whileFalse: [  
				"This means we moved to the next group.
				We create a new group for storing events"
				groupedEvents add: (currentTime -> currentGroup).
				currentGroup := OrderedCollection new.
				currentTime := currentTime + aDuration ].
		currentGroup add: anEvent ].
	groupedEvents add: (currentTime -> currentGroup).
	^ groupedEvents
]

{ #category : #ui }
GtRecordingPulseListener >> gtViewEventsFor: aView [
	<gtView>
	^ aView list
		title: 'Pulse events';
		priority: 50;
		items: [ pulseEvents ]
]

{ #category : #ui }
GtRecordingPulseListener >> gtViewFrameFrequencyFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Frames per second';
		priority: 10;
		items: [ 
			| groupedEvents currentTime  lastTime |
			groupedEvents := OrderedDictionary new.
			currentTime := pulseEvents first timestamp truncated.
			lastTime := pulseEvents last timestamp truncated.
			[currentTime <= lastTime] whileTrue: [
				groupedEvents at: currentTime put: OrderedCollection new.
				currentTime := currentTime + 1 second ].
			pulseEvents do: [ :anEvent |
				| eventsAtTime eventTime |
				eventTime := anEvent timestamp truncated.
				eventsAtTime := groupedEvents at: eventTime.
				eventsAtTime add: anEvent ].
			groupedEvents associations ];
		column: 'Time' format: #key;
		column: 'Frames per second' format: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
		
]

{ #category : #ui }
GtRecordingPulseListener >> gtViewFrameGroupFrequencyFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Frames per 5 seconds';
		priority: 20;
		items: [ 
			self eventsGroupedByDuration: 5 seconds ];
		column: 'Time' format: [ :assoc | assoc key asString, ' + 5 seconds' ];
		column: 'Frames average per second' format: [ :assoc | (assoc value size / 5) asFloat round: 2 ];
		send: [ :assoc | assoc value ]
]

{ #category : #ui }
GtRecordingPulseListener >> gtViewSpacesFor: aView [
	<gtView>
	^ aView list
		title: 'Spaces';
		priority: 30;
		items: [ spaceListeners ]
]

{ #category : #accessing }
GtRecordingPulseListener >> hasPulseEvents [
	^ self pulseEvents notEmpty
]

{ #category : #initialization }
GtRecordingPulseListener >> initialize [ 	
	super initialize.
	pulseEvents := OrderedCollection new.
	spaceListeners := OrderedCollection new.
]

{ #category : #pulse }
GtRecordingPulseListener >> pulse [
	pulseEvents add: (GtRecordingPulseEvent new 
		blocEvent: (BlPulseEvent new copyFrom: BlUniverse default pulseLoop pulseEvent))
]

{ #category : #accessing }
GtRecordingPulseListener >> pulseEvents [
	^ pulseEvents
]

{ #category : #registration }
GtRecordingPulseListener >> registerPulseLoop [
	BlUniverse default addPulseListener: self
]

{ #category : #registration }
GtRecordingPulseListener >> registerSpaceListenerFor: aSpace [
	| spaceListener |
	spaceListener := GtRecordingSpaceListener new 
		pulseListener: self;
		registerSpace: aSpace.
	spaceListeners add: spaceListener
]

{ #category : #registration }
GtRecordingPulseListener >> unregisterAll [
	BlUniverse default removePulseListener: self.
	spaceListeners do: #unregister
]
