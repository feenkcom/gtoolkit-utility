Class {
	#name : #GtNullAnnouncer,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance + TGtAnnouncer',
	#classTraits : 'TGtUniqueInstance classTrait + TGtAnnouncer classTrait',
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #announcer }
GtNullAnnouncer >> announce: anAnnouncement [
	"do nothing"
]

{ #category : #announcer }
GtNullAnnouncer >> announcer [
	^ self shouldNotImplement
]

{ #category : #announcer }
GtNullAnnouncer >> hasSubscriber: anObject [
	^ false
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> removeSubscription: subscription [
	"do nothing"
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> unsubscribe: anObject [
	"do nothing"
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> weak [
	"announcer weak subscribe: foo"
	^ self
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> when: anAnnouncementClass do: aValuable [
	"do nothing"
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> when: anAnnouncementClass send: aSelector to: anObject [
	"do nothing"
]

{ #category : #'announcer - subscription' }
GtNullAnnouncer >> when: anAnnouncementClass send: aSelector to: anObject for: aSubscriber [
	"do nothing"
]
