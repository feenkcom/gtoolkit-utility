"
I gate access for multiple waiting processes. Before I am released, #wait blocks and #waitTimeoutMilliseconds: waits until release or timeout. After #signal, all current and future waits proceed immediately. I am a one-shot gate built on Semaphore.
"
Class {
	#name : #GtReleaseLatch,
	#superclass : #Object,
	#instVars : [
		'released',
		'semaphore',
		'mutex',
		'waitingCount'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'gt-views' }
GtReleaseLatch >> gtStatusFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Status';
		priority: 10;
		items: {
			{'Released'. self isReleased}.
			{'Waiting processes'. semaphore size. semaphore. } };
		column: 'Property' text: [ :each | each first ];
		column: 'Value' text: [ :each | each last ];
		send: [ :each | each last ]
]

{ #category : #initialization }
GtReleaseLatch >> initialize [
	super initialize.
	released := false.
	semaphore := Semaphore new.
	mutex := Semaphore forMutualExclusion.
	waitingCount := 0
]

{ #category : #accessing }
GtReleaseLatch >> isReleased [
	^ released
]

{ #category : #synchronization }
GtReleaseLatch >> signal [
	mutex
		critical: [ released ifTrue: [ ^ self ].
			released := true.
			semaphore signalAll.
			(waitingCount ifNil: [ 0 ]) timesRepeat: [ semaphore signal ] ]
]

{ #category : #synchronization }
GtReleaseLatch >> wait [
	mutex
		critical: [ released ifTrue: [ ^ self ].
			waitingCount := (waitingCount ifNil: [ 0 ]) + 1 ].
	[ semaphore wait ]
		ensure: [ mutex critical: [ waitingCount := waitingCount - 1 ] ].
	^ self
]

{ #category : #waiting }
GtReleaseLatch >> waitTimeoutMilliseconds: milliseconds [
	"Answer true when the timeout expires, false when the latch is released."

	mutex
		critical: [ released ifTrue: [ ^ false ].
			waitingCount := (waitingCount ifNil: [ 0 ]) + 1 ].
	^ [ semaphore waitTimeoutMilliseconds: milliseconds ]
		ensure: [ mutex critical: [ waitingCount := waitingCount - 1 ] ]
]
