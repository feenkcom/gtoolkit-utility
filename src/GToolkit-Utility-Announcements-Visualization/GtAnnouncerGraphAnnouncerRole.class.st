"
I am the role of the announcer whose subscriptions are shown.
"
Class {
	#name : #GtAnnouncerGraphAnnouncerRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphAnnouncerRole >> color [
	^Color fromHexString: 'CFE2F3'
]

{ #category : #testing }
GtAnnouncerGraphAnnouncerRole >> isAnnouncer [
	^true
]

{ #category : #accessing }
GtAnnouncerGraphAnnouncerRole >> meaning [
	^'The announcer whose subscriptions are drawn'
]

{ #category : #accessing }
GtAnnouncerGraphAnnouncerRole >> title [
	^'announcer'
]
