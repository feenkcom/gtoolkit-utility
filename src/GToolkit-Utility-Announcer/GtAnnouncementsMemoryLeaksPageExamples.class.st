Class {
	#name : #GtAnnouncementsMemoryLeaksPageExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #'examples - three subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleDomainModelAndElement_strongSubscription [
	<gtExample>
	<timeLimit: 300000>
	| modelId model graphicalElementId graphicalElement extraSubscriberId extraSubscriber survivors |
	modelId := UUID new.
	model := Association new.
	model key: modelId.
	model value: Announcer new.

	graphicalElementId := UUID new.
	graphicalElement := Association new.
	graphicalElement key: graphicalElementId.
	"The graphical element can hold on to the model"
	graphicalElement value: model.

	"We create a subscription from the model to the graphical element."
	model value 
		when: Announcement 
		send: #yourself
		to: graphicalElement.
	
	"We add another weak subscription to the model, maybe for another graphical element"
	extraSubscriberId := UUID new.
	extraSubscriber := Association new.
	extraSubscriber key: extraSubscriberId.
	extraSubscriber value: 'extra subscriber'.
	model value weak
		when: Announcement 
		send: #yourself
		to: extraSubscriber.
	
	"Watch the graphical element and the model without holding on to them"
	survivors := WeakArray with: graphicalElement with: model.
	model := nil.
	graphicalElement := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	"The graphical element is not removed as through the new weak subscription
	we create a strong reference to it"
	self assert: (survivors at: 1) notNil.
	"The model is not removed as the graphical element holds on to it"
	self assert: (survivors at: 2) notNil
]

{ #category : #'examples - three subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleDomainModelAndElement_weakSubscription [
	<gtExample>
	| modelId model graphicalElementId graphicalElement extraSubscriberId extraSubscriber survivors |
	modelId := UUID new.
	model := Association new.
	model key: modelId.
	model value: Announcer new.

	graphicalElementId := UUID new.
	graphicalElement := Association new.
	graphicalElement key: graphicalElementId.
	"The graphical element can hold on to the model"
	graphicalElement value: model.

	"We create a subscription from the model to the graphical element."
	model value weak
		when: Announcement 
		send: #yourself
		to: graphicalElement.
	
	"We add another weak subscription to the model, maybe for another graphical element"
	extraSubscriberId := UUID new.
	extraSubscriber := Association new.
	extraSubscriber key: extraSubscriberId.
	extraSubscriber value: 'extra subscriber'.
	model value weak
		when: Announcement 
		send: #yourself
		to: extraSubscriber.
	
	"Watch the graphical element and the model without holding on to them"
	survivors := WeakArray with: graphicalElement with: model.
	model := nil.
	graphicalElement := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) isNil.
	self assert: (survivors at: 2) isNil.
]

{ #category : #'examples - three subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleThirdWeakSubscription [
	<gtExample>
	| targetId subscribedTarget extraTargetId extraSubscribedTagget survivors |
	targetId := UUID new.
	subscribedTarget := Association new.
	subscribedTarget key: targetId.
	subscribedTarget value: Announcer new.

	subscribedTarget value
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	subscribedTarget value weak
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	
	"We add another weak subscription to the same announcer for another object"
	extraTargetId := UUID new.
	extraSubscribedTagget := Association new.
	extraSubscribedTagget key: extraTargetId.
	extraSubscribedTagget value: 'extra subscriber'.

	subscribedTarget value weak
		when: Announcement 
		send: #yourself
		to: extraSubscribedTagget.
	"Watch the targets without holding on to them"
	survivors := WeakArray with: subscribedTarget.
	subscribedTarget := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) notNil "The reference is not removed"
]

{ #category : #'examples - two targets - two subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionDifferentObjects_clearBothSubscribers [
	<gtExample>
	| stronglyTargetId weakTargetId stronglySubscribedTarget weaklySubscribedTarget  announcer survivors |

	stronglyTargetId := UUID new.
	weakTargetId := UUID new.

	stronglySubscribedTarget := Association new.
	stronglySubscribedTarget key: stronglyTargetId.
	stronglySubscribedTarget value: 'strong target'.

	weaklySubscribedTarget := Association new.
	weaklySubscribedTarget key: weakTargetId.
	weaklySubscribedTarget value: 'weak target'.
 
	announcer := Announcer new.
	announcer
		when: Announcement 
		send: #yourself
		to: stronglySubscribedTarget.
	announcer weak
		when: Announcement 
		send: #yourself
		to: weaklySubscribedTarget.
	
	"Watch the targets without holding on to them"
	survivors := WeakArray with: stronglySubscribedTarget with: weaklySubscribedTarget.
	announcer := nil.	
	stronglySubscribedTarget := nil.
	weaklySubscribedTarget := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) isNil.
	self assert: (survivors at: 2) isNil.
]

{ #category : #'examples - two targets - two subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionDifferentObjects_clearStrongSubscriber [
	<gtExample>
	| stronglyTargetId weakTargetId stronglySubscribedTarget weaklySubscribedTarget  announcer survivors |

	stronglyTargetId := UUID new.
	weakTargetId := UUID new.

	stronglySubscribedTarget := Association new.
	stronglySubscribedTarget key: stronglyTargetId.
	stronglySubscribedTarget value: 'strong target'.

	weaklySubscribedTarget := Association new.
	weaklySubscribedTarget key: weakTargetId.
	weaklySubscribedTarget value: 'weak target'.

	announcer := Announcer new.
	announcer
		when: Announcement 
		send: #yourself
		to: stronglySubscribedTarget.
	announcer weak
		when: Announcement 
		send: #yourself
		to: weaklySubscribedTarget.
	
	"Watch the targets without holding on to them"
	survivors := WeakArray with: stronglySubscribedTarget with: weaklySubscribedTarget.
	announcer := nil.	
	stronglySubscribedTarget := nil.
	"weaklySubscribedTarget := nil."

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) notNil. "The reference is not removed"
	self assert: (survivors at: 2) notNil. "The reference is not removed"
]

{ #category : #'examples - two targets - two subscriptions' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionDifferentObjects_clearWeakSubscriber [
	<gtExample>
	| stronglyTargetId weakTargetId stronglySubscribedTarget weaklySubscribedTarget  announcer survivors |

	stronglyTargetId := UUID new.
	weakTargetId := UUID new.

	stronglySubscribedTarget := Association new.
	stronglySubscribedTarget key: stronglyTargetId.
	stronglySubscribedTarget value: 'strong target'.

	weaklySubscribedTarget := Association new.
	weaklySubscribedTarget key: weakTargetId.
	weaklySubscribedTarget value: 'weak target'.

	announcer := Announcer new.
	announcer
		when: Announcement 
		send: #yourself
		to: stronglySubscribedTarget.
	announcer weak
		when: Announcement 
		send: #yourself
		to: weaklySubscribedTarget.
	
	"Watch the targets without holding on to them"
	survivors := WeakArray with: stronglySubscribedTarget with: weaklySubscribedTarget.
		announcer := nil.	
	"stronglySubscribedTarget := nil."
	weaklySubscribedTarget := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) notNil. "The reference is not removed"
	self assert: (survivors at: 2) isNil
]

{ #category : #'examples - same target object' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionSameObject_logFinalization [
	<gtExample>
	| finalizationLog targetId subscribedTarget announcer survivors |
	finalizationLog := OrderedCollection new.

	targetId := UUID new.
	subscribedTarget := Association new.
	subscribedTarget key: targetId.
	subscribedTarget value: 'target'.

	announcer := Announcer new.
	announcer
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	announcer weak
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	
	FinalizationRegistry  default 
		add: subscribedTarget
		finalizer: (ObjectFinalizer new
			receiver: finalizationLog;
			selector: #add:;
			arguments: {targetId printString}).

	"Watch the targets without holding on to them"
	survivors := WeakArray with: subscribedTarget.
	announcer := nil.	
	subscribedTarget := nil.

	"First garbage collect triggers finalization"
	Smalltalk garbageCollect.
	self assert: finalizationLog size equals: 1.
	self assert: finalizationLog first equals: targetId printString.

	"Secong garbage collect, removes the reference to the receiver"
	Smalltalk garbageCollect.
	self assert: (survivors at: 1) isNil.
	
	^ finalizationLog
]

{ #category : #'examples - same target object' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionSameObject_targetAndAnnouncerAsSeparateObjects [
	<gtExample>
	| targetId subscribedTarget announcer survivors |
	targetId := UUID new.
	subscribedTarget := Association new.
	subscribedTarget key: targetId.
	subscribedTarget value: 'target'.

	announcer := Announcer new.
	announcer
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	announcer weak
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	
	"Watch the targets without holding on to them"
	survivors := WeakArray with: subscribedTarget.
	announcer := nil.	
	subscribedTarget := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) isNil
]

{ #category : #'examples - same target object' }
GtAnnouncementsMemoryLeaksPageExamples >> exampleWeakAndStrongSubscriptionSameObject_targetHoldsAnnouncer [
	<gtExample>
	| targetId subscribedTarget survivors |
	targetId := UUID new.
	subscribedTarget := Association new.
	subscribedTarget key: targetId.
	subscribedTarget value: Announcer new.

	subscribedTarget value
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	subscribedTarget value weak
		when: Announcement 
		send: #yourself
		to: subscribedTarget.
	
	"Watch the targets without holding on to them"
	survivors := WeakArray with: subscribedTarget.
	subscribedTarget := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].
	self assert: (survivors at: 1) isNil
]
