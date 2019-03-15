Class {
	#name : #GtRecordingSpaceFrameEvent,
	#superclass : #Object,
	#instVars : [
		'space',
		'blocEvent',
		'pulseEvent'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> blocEvent [
	^ blocEvent
]

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> blocEvent: aBlocEvent [
	blocEvent := aBlocEvent
]

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> duration [
	^ blocEvent end - blocEvent start
]

{ #category : #printing }
GtRecordingSpaceFrameEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: blocEvent class name;
		nextPutAll: ', ';
		print: blocEvent start asTime;
		nextPutAll: ', ';
		print: (blocEvent end - blocEvent start);
		nextPut: $)
	
]

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> pulseEvent: aPulseEvent [
	pulseEvent := aPulseEvent
]

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> space [
	^ space
]

{ #category : #accessing }
GtRecordingSpaceFrameEvent >> space: aSpace [
	space := aSpace
]
