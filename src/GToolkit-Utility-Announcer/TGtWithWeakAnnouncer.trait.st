Trait {
	#name : #TGtWithWeakAnnouncer,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #testing }
TGtWithWeakAnnouncer classSide >> isDeprecated [
	^ true
]

{ #category : #'announcer - subscription' }
TGtWithWeakAnnouncer >> unsubscribe: aSubscriber [

	"Unsubscribe all subscriptions of anObject from the receiver"

	announcer ifNil: [ ^ self ].
	announcer unsubscribe: aSubscriber
]

{ #category : #'announcer - subscription' }
TGtWithWeakAnnouncer >> weak [

	"Register a weak subscription."

	announcer ifNil: [ announcer := Announcer new ].

	^ announcer weak
]

{ #category : #'announcer - subscription' }
TGtWithWeakAnnouncer >> when: anAnnouncementClass send: aSelector to: anObject [

	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.
    When the message expects one argument (eg #fooAnnouncement:) the announcement is passed as argument.
    When the message expects two arguments (eg #fooAnnouncement:announcer:) both the announcement and 
    the announcer are passed as argument"

	announcer ifNil: [ announcer := Announcer new ].

	^ announcer weak when: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'announcer - subscription' }
TGtWithWeakAnnouncer >> when: anAnnouncementClass send: aSelector to: anObject for: aSubscriber [

	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.
    When the message expects one argument (eg #fooAnnouncement:) the announcement is passed as argument.
    When the message expects two arguments (eg #fooAnnouncement:announcer:) both the announcement and 
    the announcer are passed as argument"

	^ (self when: anAnnouncementClass send: aSelector to: anObject) 
		  subscriber: aSubscriber
]
