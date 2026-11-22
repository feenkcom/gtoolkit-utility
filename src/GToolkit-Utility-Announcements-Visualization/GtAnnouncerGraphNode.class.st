"
I am a node of a {{gtClass:GtAnnouncerGraph}}. I hold the real object, so clicking me in the view inspects it, and a role that gives my colour.
"
Class {
	#name : #GtAnnouncerGraphNode,
	#superclass : #Object,
	#instVars : [
		'object',
		'role',
		'description'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphNode class >> object: anObject role: aRole description: aString [
	^self new setObject: anObject role: aRole description: aString
]

{ #category : #accessing }
GtAnnouncerGraphNode >> description [
	^description
]

{ #category : #'instance creation' }
GtAnnouncerGraphNode >> element [
	^(BrVerticalPane new)
		fitContent;
		padding: (BlInsets
					top: 3
					left: 6
					bottom: 4
					right: 6);
		background: role color;
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		addChild: ((BrLabel new)
					aptitude: ((BrGlamorousLabelAptitude new)
								fontSize: 8;
								foreground: Color gray);
					text: object class name);
		addChild: ((BrLabel new)
					aptitude: (BrGlamorousLabelAptitude new fontSize: 11);
					text: description);
		yourself
]

{ #category : #testing }
GtAnnouncerGraphNode >> isAnnouncer [
	^role isAnnouncer
]

{ #category : #testing }
GtAnnouncerGraphNode >> isRoot [
	^role isRoot
]

{ #category : #testing }
GtAnnouncerGraphNode >> isSubscriber [
	^role isSubscriber
]

{ #category : #accessing }
GtAnnouncerGraphNode >> joinRole: aRole [
	role := role joinedWith: aRole
]

{ #category : #accessing }
GtAnnouncerGraphNode >> object [
	^object
]

{ #category : #accessing }
GtAnnouncerGraphNode >> objectToInspect [
	^object
]

{ #category : #printing }
GtAnnouncerGraphNode >> printOn: aStream [
	aStream
		nextPutAll: object class name;
		nextPutAll: ': ';
		nextPutAll: description
]

{ #category : #accessing }
GtAnnouncerGraphNode >> roleTitle [
	^role title
]

{ #category : #initialization }
GtAnnouncerGraphNode >> setObject: anObject role: aRole description: aString [
	object := anObject.
	role := aRole.
	description := aString
]
