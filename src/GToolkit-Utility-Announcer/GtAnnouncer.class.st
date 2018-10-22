Class {
	#name : #GtAnnouncer,
	#superclass : #Announcer,
	#traits : 'GtExtraSubscriptionTrait + GtAssertingTrait',
	#classTraits : 'GtExtraSubscriptionTrait classTrait + GtAssertingTrait classTrait',
	#instVars : [
		'observedAnnouncer'
	],
	#category : #'GToolkit-Utility-Announcer-Asynchronous'
}

{ #category : #'instance creation' }
GtAnnouncer class >> common [
	^ self new observedAnnouncer: Announcer new
]

{ #category : #'instance creation' }
GtAnnouncer class >> system [
	^ self new observedAnnouncer: SystemAnnouncer uniqueInstance
]

{ #category : #announcer }
GtAnnouncer >> announcer [
	<return: #Announcer>
	^ self observedAnnouncer
]

{ #category : #'private - subscriptions' }
GtAnnouncer >> handleObservedAnnouncement: anAnnouncement [
	self announce: anAnnouncement
]

{ #category : #accessing }
GtAnnouncer >> observedAnnouncer [
	<return: #Announcer>
	^ observedAnnouncer
]

{ #category : #accessing }
GtAnnouncer >> observedAnnouncer: anAnnouncer [ 
	self unsubscribeFromAnnouncer.
	self 
		assert: [ anAnnouncer notNil ]
		description: [ 'Announcer must be non-nil' ].
	observedAnnouncer := anAnnouncer.
	self subscribeToAnnouncer.
]

{ #category : #'private - subscriptions' }
GtAnnouncer >> subscribeToAnnouncer [
	(observedAnnouncer 
		subscribe: Announcement 
		send: #handleObservedAnnouncement:  
		to: self) subscriber: self.
]

{ #category : #'private - subscriptions' }
GtAnnouncer >> unsubscribeFromAnnouncer [
	observedAnnouncer ifNil: [ ^ self ].
	observedAnnouncer unsubscribe: self.
]
