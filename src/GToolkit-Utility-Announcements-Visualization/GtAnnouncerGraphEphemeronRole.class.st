"
I am the role of an ephemeron: a FinalizationRegistry entry or a WeakKeyAssociation of a mixed registry.
"
Class {
	#name : #GtAnnouncerGraphEphemeronRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphEphemeronRole >> color [
	^Color fromHexString: 'FCE5CD'
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronRole >> meaning [
	^'A global entry, or a weak group of a mixed registry: keeps its value only while its key is reachable from elsewhere'
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronRole >> title [
	^'ephemeron'
]
