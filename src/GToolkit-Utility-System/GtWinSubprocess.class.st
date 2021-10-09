Class {
	#name : #GtWinSubprocess,
	#superclass : #GtUnixSubprocess,
	#category : 'GToolkit-Utility-System-GToolkit-Utility-System'
}

{ #category : #accessing }
GtWinSubprocess >> closeAndCleanStreams [

	self flag: 'FIXME no streams, so ignoring is fine?'
]

{ #category : #accessing }
GtWinSubprocess >> environmentAt: key put: value [

	self flag: 'FIXME ignore for now'
]

{ #category : #accessing }
GtWinSubprocess >> isRunning [

	^ self process isRunning or: [ self process isComplete not ]
]

{ #category : #accessing }
GtWinSubprocess >> process [

	^ process ifNil: [ process := OSWSWinProcess new ]
]

{ #category : #accessing }
GtWinSubprocess >> queryExitStatus [

	^ self process exitCode
]

{ #category : #accessing }
GtWinSubprocess >> runProcess [

	"Run the requested command as a separate process"

	self setCommand.
	workingDirectory ifNotNil: [ 
		self process workingDirectory: workingDirectory fullName ].
	self process basicRun
]

{ #category : #'as yet unclassified' }
GtWinSubprocess >> setCommand [

	"Set the command or shell command in the process.
	Either may be specified, but not both :-)"

	(command isNil and: [ shellCommand isNil ]) ifTrue: [ 
		self error: 'No command supplied' ].
	(command isNotNil and: [ shellCommand isNotNil ]) ifTrue: [ 
		self error: 'Only one of a command or shell command may be supplied' ].

	self flag: 'FIXME shell seems to be needed'.
	self process shellCommand: command arguments: arguments
]

{ #category : #accessing }
GtWinSubprocess >> terminateOnShutdown [

	self flag: 'FIXME check if done automatically'
]
