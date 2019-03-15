"
pulseListener := GtRecordingPulseListener new.

BlUniverse default addPulseListener: pulseListener.
BlUniverse default removePulseListener: pulseListener.
"
Class {
	#name : #GtRecordingPulseListener,
	#superclass : #Object,
	#instVars : [
		'pulseEvents'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #accessing }
GtRecordingPulseListener >> clear [
	"Do nothing. This will be called in case the universe stops."
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
		title: 'Events';
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
		column: 'Frames per second' format: [ :assoc | assoc value size ]
		
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
		column: 'Frames average' format: [ :assoc | (assoc value size / 5) asFloat round: 2 ]
]

{ #category : #initialization }
GtRecordingPulseListener >> initialize [ 	
	super initialize.
	pulseEvents := OrderedCollection new.
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
