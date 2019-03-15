Class {
	#name : #GtRecordingSpaceFrameEventsGroup,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #adding }
GtRecordingSpaceFrameEventsGroup >> addEvent: anEvent [
	self events add: anEvent
]

{ #category : #accessing }
GtRecordingSpaceFrameEventsGroup >> events [
	^ events ifNil: [ events := OrderedCollection new ] 
]

{ #category : #ui }
GtRecordingSpaceFrameEventsGroup >> gtViewEventIn: aView [
	<gtView>
	^ aView columnedList
		title: 'Space frame events';
		items: [ events ];
		column: 'Type' format: [ :aSpaceEvent | aSpaceEvent blocEvent class name ];
		column: 'Start' format: [ :aSpaceEvent | aSpaceEvent blocEvent start asTime ];
		column: 'Duration' format: [ :aSpaceEvent | aSpaceEvent duration ]
]
