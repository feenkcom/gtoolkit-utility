"
I am the role of an object that a block action references as its receiver or as a captured value, and that is not itself a subscriber. Such objects are drawn but not reported as kept alive.
"
Class {
	#name : #GtAnnouncerGraphCapturedRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphCapturedRole >> color [
	^Color white
]

{ #category : #combining }
GtAnnouncerGraphCapturedRole >> joinedWith: aRole [
	^aRole
]

{ #category : #accessing }
GtAnnouncerGraphCapturedRole >> meaning [
	^'An object a block refers to, as its receiver or as a captured variable'
]

{ #category : #accessing }
GtAnnouncerGraphCapturedRole >> title [
	^'captured object'
]
