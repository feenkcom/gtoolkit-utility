Class {
	#name : 'GtRecordingSpaceFrameEventsGroup',
	#superclass : 'Object',
	#instVars : [
		'events'
	],
	#category : 'GToolkit-Utility-MessageTally'
}

{ #category : 'adding' }
GtRecordingSpaceFrameEventsGroup >> addEvent: anEvent [
	self events add: anEvent
]

{ #category : 'accessing' }
GtRecordingSpaceFrameEventsGroup >> events [
	^ events ifNil: [ events := OrderedCollection new ] 
]

{ #category : 'ui' }
GtRecordingSpaceFrameEventsGroup >> gtViewEventIn: aView [
	<gtView>
	^ aView columnedList
		title: 'Space frame events';
		items: [ events ];
		column: 'Type' text: [ :aSpaceEvent | aSpaceEvent blocEvent class name ];
		column: 'Start' text: [ :aSpaceEvent | aSpaceEvent blocEvent start asTime ];
		column: 'Duration' text: [ :aSpaceEvent | aSpaceEvent duration ]
]
