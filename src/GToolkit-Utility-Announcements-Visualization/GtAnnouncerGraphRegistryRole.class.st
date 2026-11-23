"
I am the role of a subscription registry.
"
Class {
	#name : #GtAnnouncerGraphRegistryRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphRegistryRole >> color [
	^Color fromHexString: 'D9EAD3'
]

{ #category : #accessing }
GtAnnouncerGraphRegistryRole >> meaning [
	^'The subscription registry of the announcer, with its number of subscriptions'
]

{ #category : #accessing }
GtAnnouncerGraphRegistryRole >> title [
	^'registry'
]
