"
I am the role of a subscriber.
"
Class {
	#name : #GtAnnouncerGraphSubscriberRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphSubscriberRole >> color [
	^Color fromHexString: 'D9D2E9'
]

{ #category : #testing }
GtAnnouncerGraphSubscriberRole >> isSubscriber [
	^true
]

{ #category : #accessing }
GtAnnouncerGraphSubscriberRole >> meaning [
	^'An object that receives the announcements'
]

{ #category : #accessing }
GtAnnouncerGraphSubscriberRole >> title [
	^'subscriber'
]
