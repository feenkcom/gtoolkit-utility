Class {
	#name : #GtRecordingPulseEvent,
	#superclass : #Object,
	#instVars : [
		'blocEvent'
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

{ #category : #accessing }
GtRecordingPulseEvent >> timestamp [
	^ self blocEvent timestamp
]
