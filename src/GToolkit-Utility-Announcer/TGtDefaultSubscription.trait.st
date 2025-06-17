Trait {
	#name : #TGtDefaultSubscription,
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #announcer }
TGtDefaultSubscription >> announcer [
	<return: #Announcer>
	^ self explicitRequirement
]

{ #category : #announcer }
TGtDefaultSubscription >> hasSubscriber: anObject [
	^ self announcer hasSubscriber: anObject
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> removeSubscription: subscription [
	"Remove the given subscription from the receiver"
	^ self announcer removeSubscription: subscription
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> subscribe: anAnnouncementClass do: aValuable [
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	
	self
		deprecated: 'Please use #when:do: instead'
		transformWith: '`@receiver subscribe: `@statements1 do: `@statements2' 
						-> '`@receiver when: `@statements1 do: `@statements2'.

	^ self when: anAnnouncementClass do: aValuable
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> subscribe: anAnnouncementClass send: aSelector to: anObject [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."
	self
		deprecated: 'Please use #when:send:to: instead'
		transformWith: '`@receiver subscribe: `@statements1 send: `@statements2 to: `@anObject' 
						-> '`@receiver when: `@statements1 send: `@statements2 to: `@anObject'.
	^ self when: anAnnouncementClass do: (MessageSend receiver: anObject selector: aSelector)
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	^ self announcer unsubscribe: anObject
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> weak [
	"announcer weak subscribe: foo"
	^ self announcer weak
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> when: anAnnouncementClass do: aValuable [
	"Declare that when anAnnouncementClass is raised, aValuable is executed.  Pay attention that ushc method as well as when:do: should not be used on weak announcer since the block holds the receiver and more strongly."
		^ self announcer when: anAnnouncementClass do: aValuable
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> when: anAnnouncementClass do: aValuable for: aSubscriber [
	"Declare that when anAnnouncementClass is raised, aValuable is executed and define the subscriber."

	^ self announcer when: anAnnouncementClass do: aValuable for: aSubscriber
]

{ #category : #'announcer - subscription' }
TGtDefaultSubscription >> when: anAnnouncementClass send: aSelector to: anObject [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.
    When the message expects one argument (eg #fooAnnouncement:) the announcement is passed as argument.
    When the message expects two arguments (eg #fooAnnouncement:announcer:) both the announcement and the announcer 
    are passed as argument"
		^ self announcer when: anAnnouncementClass send: aSelector to: anObject
]
