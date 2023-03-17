Class {
	#name : #GtSubprocessWithInMemoryOutputExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'commands'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtSubprocessWithInMemoryOutputExamples >> commands [

	^ commands ifNil: [ commands := OSPlatform current isWindows
		ifTrue: [ GtExternalProcessExamplesWindowsCommands new ]
		ifFalse: [ GtExternalProcessExamplesUnixCommands new ] ]
]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> envVariable [
	"Demonstrate setting an environment variable"
	<gtExample>
	| process |

	process := self commands echoTestEnvProcess.
	self deny: (process envVariables includesKey: #GT_TEST_ENV_VAR).
	process environmentAt: #GT_TEST_ENV_VAR asString put: 'hello'.
	process runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> hasProcess [
	"Demonstrate use of the #hasProcess test"
	<gtExample>
	| process |

	process := self commands sleepProcess arguments: #('300').
	self 
		deny: process hasProcess
		description: 'Process has a sub-process before being started'.
	process run.
	self 
		assert: process hasProcess
		description: 'Process doesn''t have a sub-process after being started'.

]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> isRunning [ 
	"Demonstrate use of the #isRunning test"
	<gtExample>
	| process tryCount |

	process := self commands sleepProcess arguments: #('300').
	self 
		deny: process isRunning
		description: 'Process is running before being started'.
	process run.
	self 
		assert: process isRunning
		description: 'Process isn''t running after being started'.
	process terminate.
	"Give the OS time to register the process termination"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].
	self 
		deny: process isRunning
		description: 'Process is still running after being killed'.
]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> isSuccess [
	"Demonstrate use of the #isSuccess test"
	<gtExample>
	| process tryCount |

	process := self commands successProcess.
	process runAndWait.
	self assert: process isSuccess
		description: 'Expected process success'.

	process := self commands failProcess.
	process runAndWait.
	self deny: process isSuccess
		description: 'Expected process failure'.

	process := self commands sleepProcess arguments: #('300').
	process run.
	"Give the OS time to register the process startup"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning not ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].
	self assert: process isRunning
		description: 'Process didn''t start running'.
	process terminate.
	"Give the OS time to register the process termination"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].

	self deny: process isSuccess
		description: 'Process didn''t terminate'.
]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> kill [
	"Demonstrate use #terminate and confirm that the exit handlers aren't run"
	<gtExample>
	| process tryCount |

	process := self commands exitHandlerProcess: nil.
	process runAndWait.
	self assert: process isSuccess
		description: 'Expected process success'.
	self assert: (process stdout indexOfSubCollection: #quitting) > 0
		description: 'Expected quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0
		description: 'Expected exiting message'.

	process := self commands exitHandlerProcess: '300'.
	process run.
	"Give the OS time to run the process"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning ] ] whileFalse:
		[ 100 milliSeconds wait.
		tryCount := tryCount - 1 ].
	process kill.
	tryCount := 10.
	[ tryCount > 0 and: [ process isComplete not ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].
	self assert: (process stdout indexOfSubCollection: #quitting) = 0
		description: 'Unexpectedly found quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) = 0
		description: 'Unexpectedly found exiting message'.


]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> retryCommand [
	"Demonstrate use of the retryCount"
	<gtExample>
	| fr process |

	OSPlatform current isLinux ifFalse: [ ^ self ].

	fr := 'retryCommand-example.stdout' asFileReference.
	fr ensureDelete.
	process := GtSubprocessWithInMemoryOutput new
		shellCommand: 'echo -n x >> retryCommand-example.stdout; exit 1';
		retryCount: 3;
		runAndWait.
	self assert: fr contents trimBoth equals: 'xxx'.
	fr ensureDelete.
]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> shellCommand [
	"Demonstrate using a shell command"
	<gtExample>
	| process |

	"Isn't valid on Windows"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	process := GtSubprocessWithInMemoryOutput new
		shellCommand: 'echo "hello"';
		runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> shellCommandWithStdin [
	"Demonstrate using a shell command and writing to stdin"
	<gtExample>
	| process |

	"Isn't valid on Windows"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	process := GtSubprocessWithInMemoryOutput new
		shellCommand: 'wc -m';
		runAndSignal.
	
	process stdinStream
		nextPutAll: 'hello';
		close.
		
	process wait.
	
	self assert: process stdout trimBoth equals: '5'.
]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> sigterm [
	"Demonstrate use #sigterm and confirm that the exit handlers are run"
	<gtExample>
	| process tryCount |

	"sigterm is only supported on Unix"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	process := self commands exitHandlerProcess: nil.
	process runAndWait.
	self assert: process isSuccess
		description: 'Expected process success'.
	self assert: (process stdout indexOfSubCollection: #quitting) > 0
		description: 'Expected quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0
		description: 'Expected exiting message'.

	process := self commands exitHandlerProcess: '300'.
	process runAndSignal.
	"Give the OS time to run the process"
	tryCount := 10.
	[ 50 milliSeconds wait.
	tryCount > 0 and: [ process isRunning not ] ] whileTrue:
		[ tryCount := tryCount - 1 ].
	process sigterm.
	process wait.
	self assert: (process stdout indexOfSubCollection: #quitting) = 0
		description: 'Unexpectedly found quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0
		description: 'Expected exiting message'.


]

{ #category : #examples }
GtSubprocessWithInMemoryOutputExamples >> workingDirectory [
	"Demonstrate setting a working directory"
	<gtExample>
	| process workingDirectory |

	workingDirectory := 'pharo-local' asFileReference.
	self assert: workingDirectory isDirectory.

	process := GtSubprocessWithInMemoryOutput new
		command: self commands pwdCommand;
		errorBlock: [ :proc | self error: 'Failed to run pwd' ];
		runAndWait.
	self assert: process stdout trimBoth equals: FileLocator workingDirectory resolve fullName.

	process := GtSubprocessWithInMemoryOutput new
		command: self commands pwdCommand;
		errorBlock: [ :proc | self error: 'Failed to run pwd' ];
		workingDirectory: workingDirectory;
		runAndWait.
	self assert: process stdout trimBoth equals: workingDirectory fullName.

]
