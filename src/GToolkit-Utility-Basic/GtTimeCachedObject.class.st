Class {
	#name : #GtTimeCachedObject,
	#superclass : #Object,
	#instVars : [
		'getBlock',
		'value',
		'cacheTime',
		'cacheTimeout',
		'mutex'
	],
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #'instance creation' }
GtTimeCachedObject class >> get: aBlock timeout: aDuration [

	^ self new initialize: aBlock timeout: aDuration
]

{ #category : #accessing }
GtTimeCachedObject >> cacheTimeout [

	^ cacheTimeout
]

{ #category : #accessing }
GtTimeCachedObject >> initialize [

	super initialize.
	mutex := Mutex new.
	cacheTimeout := DateAndTime yesterday.
]

{ #category : #initalization }
GtTimeCachedObject >> initialize: aBlock timeout: aDuration [

	getBlock := aBlock.
	cacheTime := aDuration.
]

{ #category : #testing }
GtTimeCachedObject >> isExpired [
	^ DateAndTime now > cacheTimeout
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
		cacheTimeout := DateAndTime now + cacheTime.
		value ].
]

{ #category : #accessing }
GtTimeCachedObject >> rawValue [
	^ value
]

{ #category : #accessing }
GtTimeCachedObject >> value [
	"Answer the receiver's value, updating if the timeout has expired"

	DateAndTime now <= cacheTimeout ifTrue: [ ^ value ].
	"The whole point of the cached object is that determining the value is slow, so
	- ensure that it is only being retrieved once at a time (the mutex), and
	- update cacheTimeout after it has been retrieved.
	If the value has been updated while waiting for the mutex, just answer it."
	^ mutex critical:
		[ DateAndTime now > cacheTimeout ifTrue:
			[ value := getBlock value.
			cacheTimeout := DateAndTime now + cacheTime ].
		value ].
]
