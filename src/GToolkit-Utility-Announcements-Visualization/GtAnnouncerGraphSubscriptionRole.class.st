"
I am the role of a subscription.
"
Class {
	#name : #GtAnnouncerGraphSubscriptionRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphSubscriptionRole >> color [
	^Color fromHexString: 'FFF2CC'
]

{ #category : #accessing }
GtAnnouncerGraphSubscriptionRole >> meaning [
	^'One subscription: announcement class → action'
]

{ #category : #accessing }
GtAnnouncerGraphSubscriptionRole >> title [
	^'subscription'
]
