"
I am the role of a block used as the action of a subscription.
"
Class {
	#name : #GtAnnouncerGraphBlockRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphBlockRole >> color [
	^Color fromHexString: 'EEEEEE'
]

{ #category : #accessing }
GtAnnouncerGraphBlockRole >> meaning [
	^'The block action of a subscription'
]

{ #category : #accessing }
GtAnnouncerGraphBlockRole >> title [
	^'block'
]
