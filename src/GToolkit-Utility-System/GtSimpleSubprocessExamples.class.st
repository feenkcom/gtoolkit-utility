Class {
	#name : #GtSimpleSubprocessExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GtSimpleSubprocessExamples >> envVariable [
	"Demonstrate setting an environment variable"
	<gtExample>
	| process |

	process := GtUnixSubprocess new.
	self deny: (process envVariables includesKey: #GT_TEST_ENV_VAR).
	process environmentAt: #GT_TEST_ENV_VAR asString put: 'hello'.
	process
		shellCommand: 'echo "$GT_TEST_ENV_VAR"';
		runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSimpleSubprocessExamples >> hasProcess [
	"Demonstrate use of the #hasProcess test"
	<gtExample>
	| process |

	process := GtUnixSubprocess new
		command: 'sleep';
		arguments: #('1').
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

	process := GtUnixSubprocess new
		command: 'sleep';
		arguments: #('300').
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

	process := GtUnixSubprocess new
		command: 'true'.
	process runAndWait.
	self assert: process isSuccess.

	process := GtUnixSubprocess new
		command: 'false'.
	process runAndWait.
	self deny: process isSuccess.

	process := GtUnixSubprocess new
		command: 'sleep';
		arguments: #('300').
	process run.
	"Give the OS time to register the process startup"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning not ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].
	self assert: process isRunning.
	process terminate.
	"Give the OS time to register the process termination"
	tryCount := 10.
	[ tryCount > 0 and: [ process isRunning ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].

	self deny: process isSuccess.
]

{ #category : #examples }
GtSimpleSubprocessExamples >> kill [
	"Demonstrate use #terminate and confirm that the exit handlers aren't run"
	<gtExample>
	| script process tryCount |

	script := FileLocator localDirectory / 'iceberg/feenkcom/gtoolkit-external-process/tests/scripts/exithandler.sh'.
	self assert: script exists.

	process := GtUnixSubprocess new
		command: script fullName.
	process runAndWait.
	self assert: process isSuccess.
	self assert: (process stdout indexOfSubCollection: #quitting) > 0.
	self assert: (process stdout indexOfSubCollection: #exiting) > 0.

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
	[ tryCount > 0 and: [ process isComplete not ] ] whileTrue:
		[ 50 milliSeconds wait.
		tryCount := tryCount - 1 ].
	self assert: (process stdout indexOfSubCollection: #quitting) equals: 0.
	self assert: (process stdout indexOfSubCollection: #exiting) equals: 0.


]

{ #category : #examples }
GtSimpleSubprocessExamples >> shellCommand [
	"Demonstrate using a shell command"
	<gtExample>
	| process |

	process := GtUnixSubprocess new
		shellCommand: 'echo "hello"';
		runAndWait.
	self assert: process stdout trimBoth equals: 'hello'.

]

{ #category : #examples }
GtSimpleSubprocessExamples >> workingDirectory [
	"Demonstrate setting a working directory"
	<gtExample>
	| process workingDirectory |

	workingDirectory := 'pharo-local' asFileReference.
	self assert: workingDirectory isDirectory.

	process := GtUnixSubprocess new
		command: 'pwd';
		runAndWait.
	self assert: process stdout trimBoth equals: FileLocator workingDirectory resolve fullName.

	process := GtUnixSubprocess new
		command: 'pwd';
		workingDirectory: workingDirectory;
		runAndWait.
	self assert: process stdout trimBoth equals: workingDirectory fullName.

]
