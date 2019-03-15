Class {
	#name : #GtRecordingPulseEvent,
	#superclass : #Object,
	#instVars : [
		'blocEvent',
		'spaceEvents'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #accessing }
GtRecordingPulseEvent >> blocEvent [
	^ blocEvent
]

{ #category : #accessing }
GtRecordingPulseEvent >> blocEvent: aBlocEvent [
	blocEvent := aBlocEvent
]

{ #category : #ui }
GtRecordingPulseEvent >> gtViewSpacesIn: aView [
	<gtView>
	^ aView list 
		title: 'Space events';
		items: [ spaceEvents associations ];
		itemFormat: [ :assoc | assoc key ];
		send: [ :assoc | assoc value ]
]

{ #category : #initialization }
GtRecordingPulseEvent >> initialize [
	super initialize.
	spaceEvents := OrderedDictionary new.
]

{ #category : #printing }
GtRecordingPulseEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self printTimeIncludingSeconds;
		nextPut: $)
]

{ #category : #printing }
GtRecordingPulseEvent >> printTimeIncludingSeconds [
	^ String streamContents: [:s | 
		self timestamp printYMDOn: s.
		s nextPut: Character space.
		self timestamp printHMSOn: s ]
]

{ #category : #recording }
GtRecordingPulseEvent >> recordSpaceEvent: aSpaceEvent [ 
	| currentSpaceEvents |
	currentSpaceEvents := spaceEvents 
		at: aSpaceEvent space 
		ifAbsentPut: [ GtRecordingSpaceFrameEventsGroup new ].
	currentSpaceEvents addEvent: aSpaceEvent
]

{ #category : #accessing }
GtRecordingPulseEvent >> timestamp [
	^ self blocEvent timestamp
]
