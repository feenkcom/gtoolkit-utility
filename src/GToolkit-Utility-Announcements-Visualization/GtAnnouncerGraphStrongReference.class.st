"
I am a strong reference: a solid dark line. I keep my target alive.
"
Class {
	#name : #GtAnnouncerGraphStrongReference,
	#superclass : #GtAnnouncerGraphReferenceKind,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphStrongReference >> color [
	^Color black alpha: 0.75
]

{ #category : #testing }
GtAnnouncerGraphStrongReference >> keepsTargetAlive [
	^true
]

{ #category : #accessing }
GtAnnouncerGraphStrongReference >> meaning [
	^'Keeps its target alive'
]

{ #category : #accessing }
GtAnnouncerGraphStrongReference >> title [
	^'strong'
]
