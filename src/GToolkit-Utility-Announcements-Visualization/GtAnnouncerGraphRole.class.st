"
I am the role of a node in a {{gtClass:GtAnnouncerGraph}}. My subclasses give the colour of the node and answer whether it is the root, the announcer or a subscriber. When an object is reached in two roles, the node keeps the first one, except that a subscriber role replaces a captured one ({{gtMethod:GtAnnouncerGraphRole>>joinedWith:}}).
"
Class {
	#name : #GtAnnouncerGraphRole,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphRole >> color [
	^self subclassResponsibility
]

{ #category : #testing }
GtAnnouncerGraphRole >> isAnnouncer [
	^false
]

{ #category : #testing }
GtAnnouncerGraphRole >> isRoot [
	^false
]

{ #category : #testing }
GtAnnouncerGraphRole >> isSubscriber [
	^false
]

{ #category : #combining }
GtAnnouncerGraphRole >> joinedWith: aRole [
	^self
]

{ #category : #accessing }
GtAnnouncerGraphRole >> meaning [
	^self subclassResponsibility
]

{ #category : #accessing }
GtAnnouncerGraphRole >> title [
	^self subclassResponsibility
]
