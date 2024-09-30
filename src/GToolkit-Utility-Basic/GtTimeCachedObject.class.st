Class {
	#name : #GtTimeCachedObject,
	#superclass : #Object,
	#instVars : [
		'getBlock',
		'value',
		'cacheTime',
		'mutex',
		'lastRetrieved'
	],
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #'instance creation' }
GtTimeCachedObject class >> get: aBlock timeout: aDuration [

	^ self new initialize: aBlock timeout: aDuration
]

{ #category : #accessing }
GtTimeCachedObject >> cacheTimeout [

	^ lastRetrieved + cacheTime
]

{ #category : #accessing }
GtTimeCachedObject >> initialize [

	super initialize.
	mutex := Mutex new.
	lastRetrieved := DateAndTime epoch.
]

{ #category : #initalization }
GtTimeCachedObject >> initialize: aBlock timeout: aDuration [

	aDuration > 124 years ifTrue:
		[ self error: 'Unreasonable timeout: ', aDuration asString ].
	getBlock := aBlock.
	cacheTime := aDuration.
]

{ #category : #testing }
GtTimeCachedObject >> isExpired [
	^ DateAndTime now > self cacheTimeout
]

{ #category : #accessing }
GtTimeCachedObject >> mutexStatus [
	^ (mutex instVarNamed: #semaphore)
		critical: [ 'Free' ]
		ifLocked: [ 'Locked' ]
]

{ #category : #accessing }
GtTimeCachedObject >> newValue [
	"Answer the receiver's value, updating it regardless of the timeout"

	^ mutex critical:
		[ value := getBlock value.
		lastRetrieved := DateAndTime now.
		value ].
]

{ #category : #accessing }
GtTimeCachedObject >> rawValue [
	^ value
]

{ #category : #accessing }
GtTimeCachedObject >> setExpired [
	"Force the value to be updated on the next #value request"

	lastRetrieved := DateAndTime epoch.
]

{ #category : #accessing }
GtTimeCachedObject >> value [
	"Answer the receiver's value, updating if the timeout has expired"

	^ self valueWithin: cacheTime
]

{ #category : #accessing }
GtTimeCachedObject >> valueWithin: aDuration [
	"Answer the receiver's value, updating it if the value is more than aDuration old"

	DateAndTime now <= self cacheTimeout ifTrue: [ ^ value ].
	"The whole point of the cached object is that determining the value is slow, so
	- ensure that it is only being retrieved once at a time (the mutex), and
	- update cacheTimeout after it has been retrieved.
	If the value has been updated while waiting for the mutex, just answer it."
	^ mutex critical:
		[ DateAndTime now <= self cacheTimeout
 			ifTrue: [ value ]
 			ifFalse: [ self newValue ] ].
]
