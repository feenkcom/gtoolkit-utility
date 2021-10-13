Class {
	#name : #GtSimpleSubprocessExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'commands'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtSimpleSubprocessExamples >> commands [

	^ commands ifNil: [ commands := OSPlatform current isWindows
		ifTrue: [ GtExternalProcessExamplesWindowsCommands new ]
		ifFalse: [ GtExternalProcessExamplesUnixCommands new ] ]
]

{ #category : #examples }
GtSimpleSubprocessExamples >> envVariable [
	"Demonstrate setting an environment variable"
	<gtExample>
	| process |

	process := GtUnixSubprocess new.
	self deny: (process envVariables includesKey: #GT_TEST_ENV_VAR).
	process environmentAt: #GT_TEST_ENV_VAR asString put: 'hello'.
	process
		command: self commands echoTestEnvScript fullName;
		runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSimpleSubprocessExamples >> hasProcess [
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
GtSimpleSubprocessExamples >> isRunning [ 
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
GtSimpleSubprocessExamples >> isSuccess [
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
GtSimpleSubprocessExamples >> kill [
	"Demonstrate use #terminate and confirm that the exit handlers aren't run"
	<gtExample>
	| script process tryCount |

	script := self commands exitHandlerScript.
	self assert: script exists
		description: script fullName, ' doesn''t exist'.

	process := GtUnixSubprocess new
		command: script fullName.
	process runAndWait.
	self assert: process isSuccess
		description: 'Expected process success'.
	self assert: (process stdout indexOfSubCollection: #quitting) > 0
		description: 'Expected quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0
		description: 'Expected exiting message'.

	process := GtUnixSubprocess new
		command: script fullName;
		arguments: #('300').
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
GtSimpleSubprocessExamples >> shellCommand [
	"Demonstrate using a shell command"
	<gtExample>
	| process |

	"Isn't valid on Windows"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	process := GtUnixSubprocess new
		shellCommand: 'echo "hello"';
		runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSimpleSubprocessExamples >> sigterm [
	"Demonstrate use #sigterm and confirm that the exit handlers are run"
	<gtExample>
	| script process tryCount |

	"sigterm is only supported on Unix"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	script := self commands exitHandlerScript.
	self assert: script exists
		description: script fullName, ' doesn''t exist'.

	process := GtUnixSubprocess new
		command: script fullName.
	process runAndWait.
	self assert: process isSuccess
		description: 'Expected process success'.
	self assert: (process stdout indexOfSubCollection: #quitting) > 0
		description: 'Expected quitting message'.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0
		description: 'Expected exiting message'.

	process := GtUnixSubprocess new
		command: script fullName;
		arguments: #('300').
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
GtSimpleSubprocessExamples >> workingDirectory [
	"Demonstrate setting a working directory"
	<gtExample>
	| process workingDirectory |

	workingDirectory := 'pharo-local' asFileReference.
	self assert: workingDirectory isDirectory.

	process := GtUnixSubprocess new
		command: self commands pwdCommand;
		runAndWait.
	self assert: process stdout trimBoth equals: FileLocator workingDirectory resolve fullName.

	process := GtUnixSubprocess new
		command: self commands pwdCommand;
		workingDirectory: workingDirectory;
		runAndWait.
	self assert: process stdout trimBoth equals: workingDirectory fullName.

]
