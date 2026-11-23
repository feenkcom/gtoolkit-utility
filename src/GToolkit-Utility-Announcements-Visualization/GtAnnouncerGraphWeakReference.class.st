"
I am a weak reference: a dashed grey line. I do not keep my target alive.
"
Class {
	#name : #GtAnnouncerGraphWeakReference,
	#superclass : #GtAnnouncerGraphReferenceKind,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphWeakReference >> borderPainted: aColor [
	^(BlBorder builder)
		paint: aColor;
		width: 1;
		dashed;
		build
]

{ #category : #accessing }
GtAnnouncerGraphWeakReference >> color [
	^Color gray
]

{ #category : #testing }
GtAnnouncerGraphWeakReference >> keepsTargetAlive [
	^false
]

{ #category : #accessing }
GtAnnouncerGraphWeakReference >> meaning [
	^'Does not keep its target alive'
]

{ #category : #accessing }
GtAnnouncerGraphWeakReference >> title [
	^'weak'
]
