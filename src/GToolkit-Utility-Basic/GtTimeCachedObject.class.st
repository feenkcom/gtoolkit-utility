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

{ #category : #accessing }
GtTimeCachedObject >> newValue [
	"Answer the receiver's value, updating it regardless of the timeout"

	^ mutex critical:
		[ value := getBlock value.
		cacheTimeout := DateAndTime now + cacheTime.
		value ].
]

{ #category : #accessing }
GtTimeCachedObject >> value [
	"Answer the receiver's value, updating if the timeout has expired"

	DateAndTime now <= cacheTimeout ifTrue: [ ^ value ].
	"The whole point of the cached object is that determining the value is slow, so
	- ensure that it is only being retrieved once at a time (the mutex), and
	- update cacheTimeout after it has been retrieved"
	^ mutex critical:
		[ value := getBlock value.
		cacheTimeout := DateAndTime now + cacheTime.
		value ].
]
