"
I am the reference from an ephemeron to its key: a dotted blue line. I do not keep the key alive.
"
Class {
	#name : #GtAnnouncerGraphEphemeronKeyReference,
	#superclass : #GtAnnouncerGraphReferenceKind,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphEphemeronKeyReference >> arcElementHighlighted: isHighlighted [
	^self lineElementHighlighted: isHighlighted
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronKeyReference >> borderPainted: aColor [
	^(BlBorder builder)
		paint: aColor;
		width: 1.5;
		dashedSmall;
		build
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronKeyReference >> color [
	^Color fromHexString: '3D85C6'
]

{ #category : #testing }
GtAnnouncerGraphEphemeronKeyReference >> isEphemeronKey [
	^true
]

{ #category : #testing }
GtAnnouncerGraphEphemeronKeyReference >> keepsTargetAlive [
	^false
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronKeyReference >> meaning [
	^'The key of an ephemeron; does not keep its target alive'
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronKeyReference >> title [
	^'ephemeron key'
]
