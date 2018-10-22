Class {
	#name : #GtAsyncAnnouncer,
	#superclass : #GtAnnouncer,
	#instVars : [
		'minSuspencion',
		'receivedAnnouncements',
		'mutex',
		'isActive',
		'process'
	],
	#category : #'GToolkit-Utility-Announcer-Asynchronous'
}

{ #category : #'private - process' }
GtAsyncAnnouncer >> ensureActiveProcess [
	mutex critical: [
		isActive ifTrue: [ ^ self ].
		isActive := true.
		self startProcess ]
]

{ #category : #'private - subscriptions' }
GtAsyncAnnouncer >> handleObservedAnnouncement: anAnnouncement. [
	self ensureActiveProcess.
	receivedAnnouncements nextPut: anAnnouncement
]

{ #category : #initialization }
GtAsyncAnnouncer >> initialize [
	super initialize.
	minSuspencion := 200 milliSeconds.
	receivedAnnouncements := AtomicSharedQueue new.
	mutex := Mutex new.
	isActive := false.
	process := nil.
]

{ #category : #'private - process' }
GtAsyncAnnouncer >> startProcess [
	process := [ 
		self suspencion wait.
		receivedAnnouncements flush: [ :eachAnnouncement | 
			self announce: eachAnnouncement ].
		mutex critical: [ isActive := false ].
		]
			forkAt: Processor userBackgroundPriority 
			named: self className, ' process'
]

{ #category : #accessing }
GtAsyncAnnouncer >> suspencion [
	<return: #Duration>
	^ minSuspencion
]
