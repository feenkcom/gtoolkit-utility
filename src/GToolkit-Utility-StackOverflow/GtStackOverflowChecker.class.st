Class {
	#name : #GtStackOverflowChecker,
	#superclass : #Object,
	#classVars : [
		'OverflowWatcherProcess'
	],
	#category : #'GToolkit-Utility-StackOverflow'
}

{ #category : #debugging }
GtStackOverflowChecker class >> callDepthForProcess: aProcess [
	| callDepth currentContext |
	callDepth := 0.
	currentContext := aProcess suspendedContext.
	currentContext ifNil: [^0].
	
	[callDepth := callDepth + 1.
	currentContext := currentContext sender.
	currentContext notNil]
			whileTrue.
	^callDepth
]

{ #category : #debugging }
GtStackOverflowChecker class >> checkForStackOverflows [
	Process allInstances do: 
			[:each |
			self checkForStackOverflowsForProcess: each
				depth: self defaultStackOverflowLimit]
]

{ #category : #debugging }
GtStackOverflowChecker class >> checkForStackOverflowsForProcess: aProcess depth: aNumber [

	(self hasStackOverflowsForProcess: aProcess depth: aNumber) ifTrue: 
		[aProcess signalException: GtStackOverflowError].
]

{ #category : #debugging }
GtStackOverflowChecker class >> defaultStackOverflowLimit [

	^10000
]

{ #category : #debugging }
GtStackOverflowChecker class >> hasStackOverflowsForProcess: aProcess depth: aNumber [
	| callDepth currentContext |

	callDepth := 0.
	currentContext := aProcess suspendedContext.
	currentContext ifNil: [ ^ false].
	
	[callDepth := callDepth + 1.
	currentContext := currentContext sender.
	currentContext notNil and: [ callDepth < aNumber ] ]
			whileTrue.
	^ currentContext notNil and: [ callDepth >= aNumber ]
]

{ #category : #testing }
GtStackOverflowChecker class >> isChecking [
	^ OverflowWatcherProcess notNil
]

{ #category : #debugging }
GtStackOverflowChecker class >> overflowCheckerProcesses [
	^Process allInstances
		select: [:each | each name = 'Stack Overflow Watcher']
]

{ #category : #'process accessing' }
GtStackOverflowChecker class >> stackOverflowDelay [
	^1000
]

{ #category : #debugging }
GtStackOverflowChecker class >> startStackOverflowWatcher [
	| process |

	self stopStackOverflowWatcher.
	process := 
			[
			[(Delay forMilliseconds: self stackOverflowDelay) wait.
			self checkForStackOverflows.
			true]
					whileTrue]
					newProcess.
	process priority: Processor highIOPriority.
	process name: 'Stack Overflow Watcher'.
	OverflowWatcherProcess := process.
	process resume.
]

{ #category : #debugging }
GtStackOverflowChecker class >> stopStackOverflowWatcher [

	OverflowWatcherProcess ifNotNil: 
		[ OverflowWatcherProcess terminate.
		OverflowWatcherProcess := nil ].
]

{ #category : #debugging }
GtStackOverflowChecker class >> suspendStackOverflowWatchersDuring: block [
	| globalWasChecking runningForCurrent |
	globalWasChecking := GtStackOverflowChecker isChecking.
	runningForCurrent := GtProcessStackOverflowChecker allInstances
				select: [:each | each process == Processor activeProcess and: [each isChecking]].
	
	[ GtStackOverflowChecker stopStackOverflowWatcher.
	runningForCurrent do: [:each | each stopStackOverflowWatcher].
	block value]
			ensure: 
				[globalWasChecking
					ifTrue: [ GtStackOverflowChecker startStackOverflowWatcher]
					ifFalse: [ GtStackOverflowChecker stopStackOverflowWatcher].
				GtProcessStackOverflowChecker allInstancesDo: 
						[:each |
						(runningForCurrent includes: each)
							ifTrue: [each startStackOverflowWatcher]
							ifFalse: [each stopStackOverflowWatcher]]]
]
