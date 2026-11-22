"
I am a named object used as a subscriber in {{gtClass:GtAnnouncerGraphExamples}}.
"
Class {
	#name : #GtAnnouncerGraphExampleObject,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphExampleObject class >> named: aString [
	^self new setName: aString
]

{ #category : #'announcement handling' }
GtAnnouncerGraphExampleObject >> onAnnouncement: anAnnouncement [
	
]

{ #category : #printing }
GtAnnouncerGraphExampleObject >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #initialization }
GtAnnouncerGraphExampleObject >> setName: aString [
	name := aString
]
