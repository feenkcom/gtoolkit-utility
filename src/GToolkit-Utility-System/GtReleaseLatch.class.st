"
I gate access for multiple waiting processes. Before I am released, processes that send #wait block. Once I am released by sending #signal, all waiting processes are resumed and any future waits proceed immediately. I am a one-shot gate built on top of Semaphore.
"
Class {
	#name : #GtReleaseLatch,
	#superclass : #Object,
	#instVars : [
		'released',
		'semaphore',
		'mutex'
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
	mutex := Semaphore forMutualExclusion
]

{ #category : #accessing }
GtReleaseLatch >> isReleased [
	^ released
]

{ #category : #synchronization }
GtReleaseLatch >> signal [
	mutex critical: [
		released ifTrue: [ ^ self ].
		released := true.
		semaphore signalAll. ].
]

{ #category : #synchronization }
GtReleaseLatch >> wait [
	mutex critical: [
		released ifTrue: [ ^ self ].
	].
	semaphore wait
]
