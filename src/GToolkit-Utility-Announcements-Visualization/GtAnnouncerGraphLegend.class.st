"
I explain the colours of the nodes and the lines of a {{gtClass:GtAnnouncerGraph}}: one row per role, per kind of reference, for the curved back references and for the red chains. {{gtMethod:GtAnnouncerGraph>>gtLegendFor:}} shows me.
"
Class {
	#name : #GtAnnouncerGraphLegend,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphLegend >> element [
	^((BrVerticalPane new)
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 10);
		cellSpacing: 6;
		addChild: (self headerNamed: 'Objects');
		addChildren: (self roles collect: 
						[:each |
						self
							rowFor: (self nodeSampleFor: each)
							title: each title
							meaning: each meaning]);
		addChild: (self headerNamed: 'References');
		addChildren: (self kinds collect: 
						[:each |
						self
							rowFor: (self lineSampleFor: (each lineElementHighlighted: false))
							title: each title
							meaning: each meaning]);
		addChild: (self
					rowFor: (self lineSampleFor: (GtAnnouncerGraphStrongReference new
									arcElementHighlighted: false))
					title: 'curved'
					meaning: 'A strong reference back to the announcer, or to an object a block refers to; the Back references toggle hides it');
		addChild: (self
					rowFor: (self lineSampleFor: (GtAnnouncerGraphStrongReference new
									lineElementHighlighted: true))
					title: 'red'
					meaning: 'A chain through which the global registry keeps a subscriber or the announcer alive while the other weak subscribers live');
		yourself) asScrollableElement
]

{ #category : #'instance creation' }
GtAnnouncerGraphLegend >> headerNamed: aString [
	^(BrLabel new)
		aptitude: (BrGlamorousLabelAptitude new bold fontSize: 13);
		text: aString;
		margin: (BlInsets top: 6)
]

{ #category : #accessing }
GtAnnouncerGraphLegend >> kinds [
	^Array
		with: GtAnnouncerGraphStrongReference new
		with: GtAnnouncerGraphWeakReference new
		with: GtAnnouncerGraphEphemeronKeyReference new
		with: GtAnnouncerGraphEphemeronValueReference new
]

{ #category : #'instance creation' }
GtAnnouncerGraphLegend >> lineSampleFor: aCurveElement [
	^(BlElement new)
		size: 70 @ 20;
		addChild: (aCurveElement
					fromAnchor: (BlAbsolutePositionAnchor position: 4 @ 14);
					toAnchor: (BlAbsolutePositionAnchor position: 64 @ 14);
					yourself);
		yourself
]

{ #category : #'instance creation' }
GtAnnouncerGraphLegend >> nodeSampleFor: aRole [
	^(BlElement new)
		size: 70 @ 20;
		addChild: ((BlElement new)
					size: 34 @ 18;
					background: aRole color;
					border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
					geometry: (BlRoundedRectangleGeometry cornerRadius: 4));
		yourself
]

{ #category : #accessing }
GtAnnouncerGraphLegend >> roles [
	^(OrderedCollection new)
		add: GtAnnouncerGraphRootRole new;
		add: GtAnnouncerGraphAnnouncerRole new;
		add: GtAnnouncerGraphRegistryRole new;
		add: GtAnnouncerGraphSubscriptionRole new;
		add: GtAnnouncerGraphSubscriberRole new;
		add: GtAnnouncerGraphEphemeronRole new;
		add: GtAnnouncerGraphBlockRole new;
		add: GtAnnouncerGraphCapturedRole new;
		yourself
]

{ #category : #'instance creation' }
GtAnnouncerGraphLegend >> rowFor: aSampleElement title: aTitle meaning: aMeaning [
	^(BrHorizontalPane new)
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		cellSpacing: 10;
		addChild: aSampleElement;
		addChild: ((BrLabel new)
					aptitude: BrGlamorousLabelAptitude new bold;
					text: aTitle;
					hExact: 130);
		addChild: ((BrLabel new)
					aptitude: BrGlamorousLabelAptitude new;
					text: aMeaning)
]
