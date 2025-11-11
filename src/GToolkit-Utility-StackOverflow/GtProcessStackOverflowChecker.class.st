Class {
	#name : #GtProcessStackOverflowChecker,
	#superclass : #Object,
	#instVars : [
		'process',
		'watcherProcess',
		'depth'
	],
	#classVars : [
		'CurrentCheckerClass'
	],
	#category : #'GToolkit-Utility-StackOverflow'
}

{ #category : #accessing }
GtProcessStackOverflowChecker class >> anyChecking [
	^ GtProcessStackOverflowChecker allInstances anySatisfy: [:i | i isChecking]
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> anyCheckingProcess: aProcess [
	<return: #Boolean>
	^ GtProcessStackOverflowChecker allInstances
		anySatisfy: [ :i | i isCheckingProcess: aProcess ]
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> checkDuring: aBlock [
	| checker |
	checker := self startForProcess: Processor activeProcess.
	^[aBlock value] ensure: [checker stopStackOverflowWatcher]
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> checkDuring: aBlock depth: anInteger [
	| checker |
	checker := self startForProcess: Processor activeProcess depth: anInteger.
	^[aBlock value] ensure: [checker stopStackOverflowWatcher]
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> currentCheckerClass [
	^ CurrentCheckerClass ifNil: [ self ]
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> currentCheckerClass: anObject [
	CurrentCheckerClass := anObject
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> startForProcess: aProcess [
	^ self
		startForProcess: aProcess
		depth: GtStackOverflowChecker defaultStackOverflowLimit
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> startForProcess: aProcess depth: aNumber [
	^ self new
		process: aProcess;
		depth: aNumber;
		startStackOverflowWatcher;
		yourself
]

{ #category : #accessing }
GtProcessStackOverflowChecker class >> stopAllStackOverflowWatchers [
	GtProcessStackOverflowChecker
		allInstancesDo: [:i | i stopStackOverflowWatcher]
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> checkForStackOverflows [
	GtStackOverflowChecker
		checkForStackOverflowsForProcess: self process
		depth: depth
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> depth: aNumber [
	depth := aNumber
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> isChecking [
	^watcherProcess notNil
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> isCheckingProcess: aProcess [
	^ self isChecking and: [ process == aProcess ]
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> process [
	^process
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> process: aProcess [
	process := aProcess
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> stackOverflowDelay [
	^ GtStackOverflowChecker stackOverflowDelay
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> startStackOverflowWatcher [
	self stopStackOverflowWatcher.
	watcherProcess := 
			[[process isTerminated] whileFalse: 
					[self checkForStackOverflows.
					(Delay forMilliseconds: self stackOverflowDelay) wait]]
					newProcess.
	watcherProcess priority: Processor highIOPriority.
	watcherProcess name: 'Process Stack Overflow Watcher'.
	watcherProcess resume
]

{ #category : #accessing }
GtProcessStackOverflowChecker >> stopStackOverflowWatcher [

	watcherProcess ifNotNil: 
		[  [ watcherProcess terminate ]
			on: ProcessAlreadyTerminating
			do: [ :ex | ].
		watcherProcess := nil ]
]
