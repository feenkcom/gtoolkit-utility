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

{ #category : #accessing }
GtRecordingPulseListener >> gtViewEventsFor: aView [
	<gtView>
	^ aView list
		title: 'Events';
		items: [ pulseEvents ]
]

{ #category : #accessing }
GtRecordingPulseListener >> gtViewFrameFrequencyFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Events';
		items: [ 
			| groupedEvents |
			groupedEvents := OrderedDictionary new..
			pulseEvents do: [ :anEvent |
				|eventsAtTime|
				eventsAtTime := (groupedEvents 
					at: anEvent printTimeIncludingSeconds 
					ifAbsentPut: [ OrderedCollection new ]).
				eventsAtTime add: anEvent ].
			groupedEvents associations ];
		column: 'Time' format: #key;
		column: 'Frames per second' format: [ :assoc | assoc value size ]
		
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
