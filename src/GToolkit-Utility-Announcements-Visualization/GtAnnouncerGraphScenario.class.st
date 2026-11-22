"
I am a scenario of {{gtClass:GtAnnouncerGraphExamples}}: an announcer together with the subscribers that must stay referenced while it is shown. My view {{gtMethod:GtAnnouncerGraphScenario>>#gtSubscriptionGraphFor:}} draws the {{gtClass:GtAnnouncerGraph}} of the announcer; its toggle shows or hides the back references to the announcer and from blocks to their receivers and captured objects. Back references that are part of a highlighted chain stay visible.
"
Class {
	#name : #GtAnnouncerGraphScenario,
	#superclass : #Object,
	#instVars : [
		'title',
		'announcer',
		'participants',
		'showsBackReferences'
	],
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #'instance creation' }
GtAnnouncerGraphScenario class >> title: aString announcer: anAnnouncer participants: aCollection [
	^self new setTitle: aString announcer: anAnnouncer participants: aCollection
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> announcer [
	^announcer
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> graph [
	^GtAnnouncerGraph forAnnouncer: announcer
]

{ #category : #views }
GtAnnouncerGraphScenario >> gtLegendFor: aView [
	<gtView>
	^(aView forward)
		title: 'Legend';
		priority: 4;
		object: [self graph];
		view: #gtLegendFor:
]

{ #category : #views }
GtAnnouncerGraphScenario >> gtObjectsFor: aView [
	<gtView>
	^(aView forward)
		title: 'Objects';
		priority: 3;
		object: [self graph];
		view: #gtObjectsFor:
]

{ #category : #views }
GtAnnouncerGraphScenario >> gtSubscriptionGraphFor: aView [
	<gtView>
	^(aView mondrian)
		title: 'Subscription graph';
		priority: 1;
		painting: [:aMondrian | self paintWith: aMondrian];
		send: [:each | each objectToInspect];
		actionToggleDo: 
				[:aToggleAction |
				aToggleAction
					label: 'Back references';
					tooltip: 'Show the references back to the announcer and to block receivers';
					isActivated: [self showsBackReferences];
					activatedAction: 
							[:aToggle :aTab |
							self showBackReferences.
							aTab phlow fireViewUpdateWish];
					deactivatedAction: 
							[:aToggle :aTab |
							self hideBackReferences.
							aTab phlow fireViewUpdateWish]];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect the graph model'
			action: [:aButton | aButton phlow spawnObject: self graph]
]

{ #category : #views }
GtAnnouncerGraphScenario >> gtWhyAliveFor: aView [
	<gtView>
	^(aView forward)
		title: 'Why alive';
		priority: 2;
		object: [self graph];
		view: #gtWhyAliveFor:
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> hideBackReferences [
	showsBackReferences := false
]

{ #category : #painting }
GtAnnouncerGraphScenario >> paintWith: aMondrian [
	showsBackReferences
		ifTrue: [self graph paintWith: aMondrian]
		ifFalse: [self graph paintWithoutBackReferencesWith: aMondrian]
]

{ #category : #printing }
GtAnnouncerGraphScenario >> printOn: aStream [
	aStream nextPutAll: title
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> registryName [
	^announcer subscriptions class name
]

{ #category : #initialization }
GtAnnouncerGraphScenario >> setTitle: aString announcer: anAnnouncer participants: aCollection [
	title := aString.
	announcer := anAnnouncer.
	participants := aCollection.
	showsBackReferences := true
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> showBackReferences [
	showsBackReferences := true
]

{ #category : #testing }
GtAnnouncerGraphScenario >> showsBackReferences [
	^showsBackReferences
]

{ #category : #accessing }
GtAnnouncerGraphScenario >> title [
	^title
]
