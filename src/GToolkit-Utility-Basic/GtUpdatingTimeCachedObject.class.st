"
GtUpdatingTimeCachedObject updates its value based on the specified time, taking the average run time to update the object in to account.
"
Class {
	#name : #GtUpdatingTimeCachedObject,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'getBlock',
		'value',
		'mutex',
		'lastRequestedTime',
		'announcer',
		'updatePromise',
		'latestException',
		'scheduleTask',
		'cacheDuration',
		'activeDuration',
		'averageDuration',
		'lastRetrievedTime',
		'updateState'
	],
	#category : #'GToolkit-Utility-Basic-Cache'
}

{ #category : #'instance creation' }
GtUpdatingTimeCachedObject class >> get: aBlock timeout: timeoutDuration active: activeDuration [

	^ self new 
		initialize: aBlock 
		timeout: timeoutDuration
		active: activeDuration
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> announcer [
	^announcer
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> cacheTimeout [

	^ lastRetrievedTime + cacheDuration
]

{ #category : #private }
GtUpdatingTimeCachedObject >> getNewValue [
	| newValue getTime |

	getTime := [ newValue := getBlock cull: self ] timeToRun.
	averageDuration := (averageDuration * 0.8) + (getTime * 0.2).
	^ newValue
]

{ #category : #ui }
GtUpdatingTimeCachedObject >> gtSummaryFor: aView [
	<gtView>
	
	^ aView columnedList
		  title: 'Summary';
		  priority: 10;
		  items: [ self summaryAttributes ];
		  column: #Attribute text: [ :item | item first ];
		  column: #Value text: [ :item | item second ];
		  send: [ :item | item last ];
		  updateWhen: GtTimeCachedObjectAnnouncement in: [ self announcer ];
			actionUpdateButton
]

{ #category : #testing }
GtUpdatingTimeCachedObject >> hasValue [
	^ value isNotNil
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> initialize [

	super initialize.
	mutex := Mutex new.
	lastRetrievedTime := DateAndTime epoch.
	announcer := Announcer new.
]

{ #category : #initalization }
GtUpdatingTimeCachedObject >> initialize: aBlock timeout: timeoutDuration active: anActiveDuration [
	| now |
	"cacheDuration is the time between updates"
	"activeDuration is the time from the lastRequestedTime when automatic updates stop"
	"The DateAndTime the value was last requested"
	"The average time to get the new value"
	now := DateAndTime now.
	getBlock := aBlock.
	cacheDuration := timeoutDuration.
	activeDuration := anActiveDuration.
	lastRequestedTime := now.
	averageDuration := cacheDuration.
	scheduleTask := TaskAtQueueTask
			valuable: [ self startUpdate ]
			at: now
			entryIdentifier: self.
	self start
]

{ #category : #testing }
GtUpdatingTimeCachedObject >> isCurrent [
	^ self hasValue and: [ DateAndTime now <= self cacheTimeout ]
]

{ #category : #testing }
GtUpdatingTimeCachedObject >> isStale [
	^ DateAndTime now > self cacheTimeout
]

{ #category : #testing }
GtUpdatingTimeCachedObject >> isValid [

	^ latestException isNil and: [ self isCurrent ]
]

{ #category : #managing }
GtUpdatingTimeCachedObject >> keepAlive [
	"Ensure that the receiver's value is being updated"

	updateState = #stopped ifTrue:
		[ self error: 'Attempt to access an invalid cache' ].
	lastRequestedTime := DateAndTime now.
	self scheduleNextUpdate.
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> lastRetrievedTime [
	^lastRetrievedTime
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> mutexStatus [
	^ (mutex instVarNamed: #semaphore)
		critical: [ 'Free' ]
		ifLocked: [ 'Locked' ]
]

{ #category : #private }
GtUpdatingTimeCachedObject >> process: newValue exception: exception [

Stdio stdout
	<< 'AKG process:';
	lf; flush.
	value := newValue.
	latestException := exception.
	lastRetrievedTime := DateAndTime now.
	mutex critical: [ updatePromise := nil ].
	self scheduleNextUpdate.
	announcer announce: (GtTimeCachedObjectAnnouncement
		newValue: newValue
		cache: self).
]

{ #category : #private }
GtUpdatingTimeCachedObject >> scheduleNextUpdate [
	"Schedule the next update unless the receiver should no longer be active"
	| now |

	now := DateAndTime now.
	(lastRequestedTime + activeDuration) <= now ifTrue: [ ^ self ].
	scheduleTask scheduledTime: lastRetrievedTime + cacheDuration - averageDuration.
	TaskAtQueue schedule: scheduleTask.
]

{ #category : #'start - stop' }
GtUpdatingTimeCachedObject >> start [

	updateState := #running.
	self scheduleNextUpdate.
]

{ #category : #private }
GtUpdatingTimeCachedObject >> startUpdate [
	"Start the update.
	This is done as a two step process as TaskAt tasks should be of short duration."

	[ self updateValue ] forkNamed: 'GtUpdateTimeCachedObject startUpdate'.
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> state [
	"Answer the state of the receiver, one of:
	- #stopped the cache is no longer updating
	- #none the value hasn't yet been retrieved
	- #stale the value's age is greater than the cacheTime
	- #current the value's age is less than or equal to the cache time"
	| now |

	updateState = #stopped ifTrue: [ ^ #stopped ].
	value ifNil: [ ^ #none ].
	now := DateAndTime now.
	now > self cacheTimeout ifTrue: [ ^ #stale ].
	^ #current
]

{ #category : #'start - stop' }
GtUpdatingTimeCachedObject >> stop [

	updateState := #stopped.
	TaskAtQueue default removeTask: scheduleTask.
]

{ #category : #ui }
GtUpdatingTimeCachedObject >> summaryAttributes [

	^ {
		{ 'State'. self state }.
		{ 'Value'. value }.
		{ 'View updated'. lastRetrievedTime. }.
	}
]

{ #category : #private }
GtUpdatingTimeCachedObject >> updateValue [

	mutex critical: [ updatePromise ifNil: 
		[ updatePromise := [ self getNewValue ] asAsyncPromise.
		(updatePromise
			then: [ :newValue | self process: newValue exception: nil ]
			otherwise: [ :ex | self process: nil exception: ex ])
				then: []
				otherwise: [ :ex | ex debug ] ] ].
]

{ #category : #accessing }
GtUpdatingTimeCachedObject >> value [
	"Answer the receiver's value"

	self keepAlive.
	^ value
]
