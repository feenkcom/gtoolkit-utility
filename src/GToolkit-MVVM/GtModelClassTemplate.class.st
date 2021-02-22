Class {
	#name : #GtModelClassTemplate,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - announcer' }
GtModelClassTemplate >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #'api - announcer' }
GtModelClassTemplate >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - announcer' }
GtModelClassTemplate >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtModelClassTemplate >> weak [
	"announcer weak subscribe: foo"

	^ self announcer weak
]
