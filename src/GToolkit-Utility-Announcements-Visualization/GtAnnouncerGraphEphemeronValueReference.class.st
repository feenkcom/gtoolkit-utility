"
I am the reference from an ephemeron to its value: a solid brown line. I keep the value alive as long as the key is reachable from elsewhere.
"
Class {
	#name : #GtAnnouncerGraphEphemeronValueReference,
	#superclass : #GtAnnouncerGraphReferenceKind,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphEphemeronValueReference >> color [
	^Color fromHexString: 'B45F06'
]

{ #category : #testing }
GtAnnouncerGraphEphemeronValueReference >> isFollowed: anEdge towards: aTargetNode in: aGraph [
	^(aGraph keyNodesOf: anEdge source)
		contains: [:each | each ~~ aTargetNode]
]

{ #category : #testing }
GtAnnouncerGraphEphemeronValueReference >> keepsTargetAlive [
	^true
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronValueReference >> meaning [
	^'Keeps its target alive only while the key is reachable from elsewhere'
]

{ #category : #accessing }
GtAnnouncerGraphEphemeronValueReference >> title [
	^'ephemeron value'
]
