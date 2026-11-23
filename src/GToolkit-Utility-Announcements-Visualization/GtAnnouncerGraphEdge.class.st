"
I am a reference between two nodes of a {{gtClass:GtAnnouncerGraph}}. My kind tells whether I keep my target alive and how I am drawn. Passive edges are drawn as arcs and do not take part in the layout. Back references, from a subscription to its announcer and from a block to its receiver or to the objects it captures, are passive and can be hidden.
"
Class {
	#name : #GtAnnouncerGraphEdge,
	#superclass : #Object,
	#instVars : [
		'source',
		'target',
		'kind',
		'label',
		'isHighlighted',
		'isPassive',
		'isBackReference'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphEdge class >> from: aSourceNode to: aTargetNode kind: aKind label: aString [
	^self new
		setSource: aSourceNode
		target: aTargetNode
		kind: aKind
		label: aString
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> beBackReference [
	isPassive := true.
	isBackReference := true
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> bePassive [
	isPassive := true
]

{ #category : #highlighting }
GtAnnouncerGraphEdge >> highlight [
	isHighlighted := true
]

{ #category : #testing }
GtAnnouncerGraphEdge >> isBackReference [
	^isBackReference
]

{ #category : #testing }
GtAnnouncerGraphEdge >> isEphemeronKey [
	^kind isEphemeronKey
]

{ #category : #testing }
GtAnnouncerGraphEdge >> isFollowedTowards: aTargetNode in: aGraph [
	^kind isFollowed: self towards: aTargetNode in: aGraph
]

{ #category : #testing }
GtAnnouncerGraphEdge >> isHighlighted [
	^isHighlighted
]

{ #category : #testing }
GtAnnouncerGraphEdge >> isPassive [
	^isPassive
]

{ #category : #testing }
GtAnnouncerGraphEdge >> keepsTargetAlive [
	^kind keepsTargetAlive
]

{ #category : #'instance creation' }
GtAnnouncerGraphEdge >> lineElement [
	^isPassive
		ifTrue: [kind arcElementHighlighted: isHighlighted]
		ifFalse: [kind lineElementHighlighted: isHighlighted]
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> objectToInspect [
	^self
]

{ #category : #printing }
GtAnnouncerGraphEdge >> printOn: aStream [
	aStream
		print: source;
		nextPutAll: ' -';
		nextPutAll: label;
		nextPutAll: ' (';
		nextPutAll: kind title;
		nextPutAll: ')-> ';
		print: target
]

{ #category : #initialization }
GtAnnouncerGraphEdge >> setSource: aSourceNode target: aTargetNode kind: aKind label: aString [
	source := aSourceNode.
	target := aTargetNode.
	kind := aKind.
	label := aString.
	isHighlighted := false.
	isPassive := false.
	isBackReference := false
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> source [
	^source
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> target [
	^target
]

{ #category : #printing }
GtAnnouncerGraphEdge >> whyAliveDescription [
	^source printString , '  →  ' , target printString
]

{ #category : #printing }
GtAnnouncerGraphEdge >> whyAliveReference [
	^label , ' (' , kind title , ')'
]

{ #category : #accessing }
GtAnnouncerGraphEdge >> whyAliveSteps [
	^#()
]
