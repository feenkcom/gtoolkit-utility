"
! __MODEL_NAME__ View Model
"
Class {
	#name : #GtViewModelClassTemplate,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - announcer' }
GtViewModelClassTemplate >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #'api - announcer' }
GtViewModelClassTemplate >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtViewModelClassTemplate >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtViewModelClassTemplate >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
