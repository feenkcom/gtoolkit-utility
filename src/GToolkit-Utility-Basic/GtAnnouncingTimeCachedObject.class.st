"
GtAnnouncingTimeCachedObject extends GtTimeCachedObject to update values in the background and announce when they are available.

If `retrievingValue` is nil, the last known value is used, otherwise the `retrievingValue` is answered.
"
Class {
	#name : #GtAnnouncingTimeCachedObject,
	#superclass : #GtTimeCachedObject,
	#instVars : [
		'announcer',
		'retrievingValue'
	],
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #'instance creation' }
GtAnnouncingTimeCachedObject class >> get: aBlock timeout: aDuration [

	^ self new initialize: aBlock timeout: aDuration
]

{ #category : #'instance creation' }
GtAnnouncingTimeCachedObject class >> get: aBlock timeout: aDuration announcer: anAnnouncer [

	^ (self new initialize: aBlock timeout: aDuration)
		announcer: anAnnouncer
]

{ #category : #'instance creation' }
GtAnnouncingTimeCachedObject class >> get: aBlock timeout: aDuration announcer: anAnnouncer retrievingValue: aString [

	^ (self new initialize: aBlock timeout: aDuration)
		announcer: anAnnouncer;
		retrievingValue: aString
]

{ #category : #accessing }
GtAnnouncingTimeCachedObject >> announcer [
	^ announcer
]

{ #category : #accessing }
GtAnnouncingTimeCachedObject >> announcer: anObject [
	announcer := anObject
]

{ #category : #'as yet unclassified' }
GtAnnouncingTimeCachedObject >> initialize [

	super initialize.
	"Self is a flag that the value hasn't been set,
	allowing nil to be a retrievingMessage"
	retrievingValue := self.
]

{ #category : #accessing }
GtAnnouncingTimeCachedObject >> retrievingValue [
	^ retrievingValue
]

{ #category : #accessing }
GtAnnouncingTimeCachedObject >> retrievingValue: anObject [
	retrievingValue := anObject
]

{ #category : #private }
GtAnnouncingTimeCachedObject >> updateAndAnnounce [

	[ super valueWithin: cacheTime ] asAsyncPromise
		then: [ :newValue |
			[ announcer announce: (GtTimeCachedObjectAnnouncement
				newValue: newValue cache: self) ]
					on: Error
					fork: [ :ex | self error: 'Unable to notify: ', ex errorMessage ] ]
		otherwise: [ :ex |
			self error: 'Unable to update: ', ex errorMessage ].
]

{ #category : #accessing }
GtAnnouncingTimeCachedObject >> valueWithin: aDuration [
	"Answer the receiver's value, updating it if the value is more than aDuration old"

	DateAndTime now <= self cacheTimeout ifTrue: [ ^ value ].
	self updateAndAnnounce.
	^ retrievingValue == self
		ifTrue: [ value ]
		ifFalse: [ retrievingValue ].
]
