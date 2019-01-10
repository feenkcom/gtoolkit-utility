Class {
	#name : #GtAsyncAnnouncerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcer-Examples'
}

{ #category : #announcing }
GtAsyncAnnouncerExamples >> announceLater [
	<gtExample>
	| aSemaphore aQueue anAnnouncer anAnnouncement aTimeout |
	aSemaphore := Semaphore new.
	aQueue := OrderedCollection new.
	anAnnouncer := self asyncAnnouncer.
	anAnnouncer 
		subscribe: Announcement 
		do: [ :theAnnouncement | aQueue add: theAnnouncement. aSemaphore signal ].
	anAnnouncement := Announcement new.
	anAnnouncer observedAnnouncer announce: anAnnouncement.
	self assert: aQueue isEmpty.
	aTimeout := aSemaphore waitTimeoutMSecs: (anAnnouncer suspencion * 20) asMilliSeconds.
	self assert: aTimeout not.
	self assert: aQueue size equals: 1.
	self assert: aQueue first equals: anAnnouncement.
	^ anAnnouncer
]

{ #category : #announcing }
GtAsyncAnnouncerExamples >> announceLaterSecondRound [
	<gtExample>
	| aSemaphore aQueue anAnnouncer anAnnouncement aTimeout |
	aSemaphore := Semaphore new.
	aQueue := OrderedCollection new.
	anAnnouncer := self announceLater.
	anAnnouncer 
		subscribe: Announcement 
		do: [ :theAnnouncement | aQueue add: theAnnouncement. aSemaphore signal ].
	anAnnouncement := Announcement new.
	anAnnouncer observedAnnouncer announce: anAnnouncement.
	self assert: aQueue isEmpty.
	aTimeout := aSemaphore waitTimeoutMSecs: (anAnnouncer suspencion * 20) asMilliSeconds.
	self assert: aTimeout not.
	self assert: aQueue size equals: 1.
	self assert: aQueue first equals: anAnnouncement.
	^ anAnnouncer
]

{ #category : #announcing }
GtAsyncAnnouncerExamples >> announceSynchronously [
	<gtExample>
	| aQueue anAnnouncer anAnnouncement |
	aQueue := OrderedCollection new.
	anAnnouncer := self announcer.
	anAnnouncer 
		subscribe: Announcement 
		do: [ :theAnnouncement | aQueue add: theAnnouncement ].
	anAnnouncement := Announcement new.
	anAnnouncer observedAnnouncer announce: anAnnouncement.
	self assert: aQueue size equals: 1.
	self assert: aQueue first equals: anAnnouncement.
	^ anAnnouncer
]

{ #category : #announcing }
GtAsyncAnnouncerExamples >> announceSynchronouslySecondRound [
	<gtExample>
	| aQueue anAnnouncer anAnnouncement |
	aQueue := OrderedCollection new.
	anAnnouncer := self announceSynchronously.
	anAnnouncer 
		subscribe: Announcement 
		do: [ :theAnnouncement | aQueue add: theAnnouncement ].
	anAnnouncement := Announcement new.
	anAnnouncer observedAnnouncer announce: anAnnouncement.
	self assert: aQueue size equals: 1.
	self assert: aQueue first equals: anAnnouncement.
	^ anAnnouncer
]

{ #category : #announcers }
GtAsyncAnnouncerExamples >> announcer [
	<gtExample>
	| anAnnouncer |
	anAnnouncer := GtAnnouncer common.
	self assert: anAnnouncer announcer notNil.
	self assert: anAnnouncer announcer class equals: Announcer.
	^ anAnnouncer
]

{ #category : #announcers }
GtAsyncAnnouncerExamples >> asyncAnnouncer [
	<gtExample>
	| anAnnouncer |
	anAnnouncer := GtAsyncAnnouncer common.
	self assert: anAnnouncer announcer notNil.
	self assert: anAnnouncer announcer class equals: Announcer.
	^ anAnnouncer
]
