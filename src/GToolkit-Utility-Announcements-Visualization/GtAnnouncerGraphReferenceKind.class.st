"
I am the kind of a reference in a {{gtClass:GtAnnouncerGraph}}. My subclasses tell whether the reference keeps its target alive and how it is drawn; a reference on a highlighted chain is drawn in red with the same width.
"
Class {
	#name : #GtAnnouncerGraphReferenceKind,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphReferenceKind >> arcElementHighlighted: isHighlighted [
	^self style: (BlParabollaArcElement new curvatureFraction: 0.35)
		highlighted: isHighlighted
]

{ #category : #accessing }
GtAnnouncerGraphReferenceKind >> border [
	^self borderPainted: self color
]

{ #category : #accessing }
GtAnnouncerGraphReferenceKind >> borderPainted: aColor [
	^BlBorder paint: aColor width: 1.5
]

{ #category : #accessing }
GtAnnouncerGraphReferenceKind >> color [
	^self subclassResponsibility
]

{ #category : #testing }
GtAnnouncerGraphReferenceKind >> isEphemeronKey [
	^false
]

{ #category : #testing }
GtAnnouncerGraphReferenceKind >> isFollowed: anEdge towards: aTargetNode in: aGraph [
	^self keepsTargetAlive
]

{ #category : #testing }
GtAnnouncerGraphReferenceKind >> keepsTargetAlive [
	^self subclassResponsibility
]

{ #category : #'instance creation' }
GtAnnouncerGraphReferenceKind >> lineElementHighlighted: isHighlighted [
	^self style: BlLineElement new highlighted: isHighlighted
]

{ #category : #accessing }
GtAnnouncerGraphReferenceKind >> meaning [
	^self subclassResponsibility
]

{ #category : #private }
GtAnnouncerGraphReferenceKind >> style: aCurveElement highlighted: isHighlighted [
	| aColor |
	aColor := isHighlighted ifTrue: [Color red] ifFalse: [self color].
	^aCurveElement
		border: (self borderPainted: aColor);
		toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder paint: aColor width: 1.5));
		zIndex: -1;
		yourself
]

{ #category : #accessing }
GtAnnouncerGraphReferenceKind >> title [
	^self subclassResponsibility
]
