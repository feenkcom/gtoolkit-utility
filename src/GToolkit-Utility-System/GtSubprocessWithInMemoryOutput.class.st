"
GtSubprocessWithInMemoryOutput is a convenience wrapper around GToolkit-ExternalProcess for the common case of executing a command and capturing stdout and stderr, which are strings that are possibly larger than one OS buffer, but small enough to fit in RAM.

Typical usage is: 

``` 
proc := (GtSubprocessWithInMemoryOutput command: 'ls' arguments: #('-lh'))
proc errorBlock: [ :proc | self error: 'External process failed, see proc' ].
proc runAndWait
proc stdout
```

If no error block is supplied the completion status should be checked with `#isSuccess`.

Processes are started with one of three messages:

- {{gtMethod:GtSubprocessWithInMemoryOutput>>#runAndWait|label=#selector}} - Run the process and wait for completion, blocking the caller.
- {{gtMethod:GtSubprocessWithInMemoryOutput>>#runAndSignal|label=#selector}} - Run the process and return immediately.  The caller can then wait for completion at a later time.
- {{gtMethod:GtSubprocessWithInMemoryOutput>>#run|label=#selector}} - Run the process without any completion notification.


Public API and Key Messages

- command:arguments: 	(class) create an instance with the supplied parameters
- errorBlock: 			Set the block to be evaluated if the process exits unsuccessfully.
		Note that this is only called if the process is successfully started and subsequently fails.
		Supplying a non-existing path, or a command that can't be found, should raise an error in the calling process.
- removeLD_LIBRARY_PATH: 	Remove LD_LIBRARY_PATH from the environment passed to the subprocess.
		This is useful on linux if the command expects the system installation of openssl.
- runAndWait: 			Execute the command and wait for completion.
- isSuccess 				Answer a boolean indicating if the command completed successfully.
- stdout, stderr: 		The output strings.

"
Class {
	#name : #GtSubprocessWithInMemoryOutput,
	#superclass : #Object,
	#instVars : [
		'builder',
		'shellCommand',
		'process',
		'errorBlock',
		'command',
		'envVariables',
		'semaphore',
		'stdoutStream',
		'stderrStream',
		'stdoutBuffer',
		'stderrBuffer',
		'outputPoll',
		'terminateOnShutdown'
	],
	#pools : [
		'LibCSignalSharedPool'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtSubprocessWithInMemoryOutput class >> command: cmd arguments: args [

	^self new
		command: cmd;
		arguments: args.
]

{ #category : #'instance creation' }
GtSubprocessWithInMemoryOutput class >> waitOnCommand: aString arguments: anArray [
	| proc |

	proc := self command: aString arguments: anArray.
	proc runAndWait.
	proc isSuccess ifFalse:
		[ self error: 'Completed with Error: ', aString ].
	^ proc
]

{ #category : #adding }
GtSubprocessWithInMemoryOutput >> addAllEnvVariablesFromParentWithoutOverride [
	"The user may have done an explicit set of a variable via #environmentAt:put: in which case
	we do not want to override it with the inherit one.
	This method allows to set all but overriden variables inherit from parent."

	"Ensure the dictionary has been set"
	self envVariables.
	Smalltalk os environment asDictionary keysAndValuesDo: [ :key :value |
		envVariables at: key ifAbsentPut: value ].

]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> addArgument: aString [
	"Append the supplied argument to the receiver's collection"

	builder arg: aString
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> arguments [

	^ builder arguments
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> arguments: aCollection [

	builder args: aCollection
]

{ #category : #cleaning }
GtSubprocessWithInMemoryOutput >> closeAndCleanStreams [
	"This is now a no-op - the library takes care of stream maintenance"
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> command [

	^ builder command
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> command: aString [

	builder command: aString
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> commandLineString [
	"Answer the equivalent command line command"
	
	^ String streamContents: [ :stream |
		stream 
			<< builder command;
			nextPut: Character space.
		builder arguments 
			do: [ :arg |
				stream << ((arg includes: Character space)
					ifTrue: [ arg printString ]
					ifFalse: [ arg ]) ]
			separatedBy: [ stream nextPut: Character space ] ]
]

{ #category : #'env building' }
GtSubprocessWithInMemoryOutput >> envVariables [
	"Answer the dictionary of environment variables that will be passed to the sub-process.
	If nil, they are inherited from the parent process (Gt)"

	^ envVariables ifNil: [ envVariables := Dictionary new ]
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> environmentAt: key put: value [

	self envVariables at: key put: value.
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> errorBlock [
	^ errorBlock
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> errorBlock: anObject [
	"A zero, one or two argument block to be evaluated when the subprocess exits with an error.
	Arguments:
	- self (a GtSubprocessWithInMemoryOutput)
	- timedOut - a Boolean indicating whether the sub-process timed out"
	errorBlock := anObject
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> exitCode [ 
	"Answer the interpretted exit status, or nil if not available"

	^ process tryWait ifNotNil: [ :status | status code ]
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> exitStatus [ 

	^ self exitCode
]

{ #category : #status }
GtSubprocessWithInMemoryOutput >> exitStatusInterpreter [

	^ process tryWait
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> gtCommandLineFor: aView [
	<gtView>

	^ aView textEditor
		title: 'Command Line';
		priority: 30;
		text: [ self commandLineString ];
		actionUpdateButton
]

{ #category : #ui }
GtSubprocessWithInMemoryOutput >> gtStderrFor: aView [
	<gtView>

	self stderr ifNil: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stderr';
		priority: 20;
		text: [ self stderr asRopedText glamorousCodeFont ];
		actionUpdateButtonTooltip: 'Update stderr'

]

{ #category : #ui }
GtSubprocessWithInMemoryOutput >> gtStdoutFor: aView [
	<gtView>

	self stdout ifNil: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stdout';
		priority: 20;
		text: [ self stdout asRopedText glamorousCodeFont ];
		actionUpdateButtonTooltip: 'Update stdout'

]

{ #category : #testing }
GtSubprocessWithInMemoryOutput >> hasProcess [
	"Answer a boolean indicating whether the receiver has a process object"

	^ process isNotNil
]

{ #category : #initialization }
GtSubprocessWithInMemoryOutput >> initialize [

	super initialize.
	builder := GtExternalProcessBuilder new.
	terminateOnShutdown := false.
]

{ #category : #testing }
GtSubprocessWithInMemoryOutput >> isComplete [

	^ self hasProcess and: 
		[ process isNull or: 
		[ process isTerminated ] ]
]

{ #category : #testing }
GtSubprocessWithInMemoryOutput >> isRunning [ 

	^ self hasProcess and: 
		[ process isNull not and: 
		[ process isTerminated not ] ]
]

{ #category : #testing }
GtSubprocessWithInMemoryOutput >> isSuccess [
	"Answer whether the command completed successfully.
	Only valid after the command has completed."

	self isComplete ifFalse: 
		[ self hasProcess ifFalse: [ self error: 'Process not yet started' ].
		process isNull ifTrue: [ self error: 'Process is null' ].
		process isTerminated ifTrue: [ self error: 'Process not terminated' ].
		self error: 'Process not yet complete' ].
	^ self exitStatusInterpreter 
		ifNil: [ false ]
		ifNotNil: [ :interpreter | interpreter isSuccess ]
]

{ #category : #actions }
GtSubprocessWithInMemoryOutput >> kill [

	process kill
]

{ #category : #printing }
GtSubprocessWithInMemoryOutput >> printOn: aStream [

	process ifNil: [ ^super printOn: aStream ].
	self isRunning ifTrue:
		[ aStream nextPutAll: 'a Running GtSubprocessWithInMemoryOutput' ]
	ifFalse: [ self isComplete ifFalse:
		[ aStream nextPutAll: 'an Incomplete GtSubprocessWithInMemoryOutput' ]
	ifTrue:
		[ self isSuccess ifTrue: 
				[ aStream nextPutAll: 'a Successfull GtSubprocessWithInMemoryOutput' ]
			ifFalse:
				[ aStream nextPutAll: 'an Unsuccessfull GtSubprocessWithInMemoryOutput' ] ] ].
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> process [

	^ process
]

{ #category : #status }
GtSubprocessWithInMemoryOutput >> queryExitStatus [

	^ self exitStatus
]

{ #category : #removing }
GtSubprocessWithInMemoryOutput >> removeLD_LIBRARY_PATH [
	"The script for running pharo sets LD_LIBRARY_PATH to the VM directory, which contains non-standard libraries.
	Unset LD_LIBRARY_PATH."

	self addAllEnvVariablesFromParentWithoutOverride.
	self envVariables removeKey: 'LD_LIBRARY_PATH' ifAbsent: 
		[ "No need to do anything if LD_LIBRARY_PATH is absent" ].
]

{ #category : #running }
GtSubprocessWithInMemoryOutput >> run [
	"Run the command without waiting"

	semaphore := nil.
	^ self runProcess
]

{ #category : #running }
GtSubprocessWithInMemoryOutput >> runAndSignal [
	"Run the command without waiting, but signal the semaphore when done"

	semaphore := Semaphore new.
	self runProcess
]

{ #category : #running }
GtSubprocessWithInMemoryOutput >> runAndWait [
	"Run the command and wait for completion"

	self runAndSignal.
	self wait.

]

{ #category : #private }
GtSubprocessWithInMemoryOutput >> runProcess [
	"Run the requested command as a separate process"

	self setCommand.
	
	builder
		pipeStdout;
		pipeStderr.

	command := builder createNativeCommand.
	envVariables ifNotNil: 
		[ command clearEnv.
		envVariables keysAndValuesDo: [ :key :value |
			command setEnv: key value: value ] ].
	process := command spawn.
	stdoutStream := String new writeStream.
	stderrStream := String new writeStream.
	stdoutBuffer := process asynchronousStdout.
	stderrBuffer := process asynchronousStderr.
	terminateOnShutdown ifTrue: [ process terminateOnShutdown ].

	outputPoll := 
		[ process waitForExitDoing: 
				[ stdoutStream nextPutAll: stdoutBuffer pollString.
				stderrStream nextPutAll: stderrBuffer pollString ].
		"Async processes have errors signalled here.
		If waiting, raise the error after signalling the semaphore (in #runAndWait)"
		semaphore
			ifNil: [ (errorBlock isNotNil and: [ self isSuccess not ])
					ifTrue: [ errorBlock cull: self cull: false ] ]
			ifNotNil: [ semaphore signal ] ] forkAt: Processor activeProcess priority + 1.

]

{ #category : #private }
GtSubprocessWithInMemoryOutput >> setCommand [
	"Set the command or shell command in the process.
	Either may be specified, but not both :-)"

	(self command isNil and: [ shellCommand isNil ]) ifTrue: 
		[ self error: 'No command supplied' ].
	(self command isNotNil and: [ shellCommand isNotNil ]) ifTrue: 
		[ self error: 'Only one of a command or shell command may be supplied' ].

	self command ifNil: 
		[ self 
			command:'/bin/sh';
			arguments: { '-c'. shellCommand. } ]

]

{ #category : #initialization }
GtSubprocessWithInMemoryOutput >> setDefaultErrorBlock [

	self errorBlock: [ | error |
		error := GtSubprocessError new process: self.
		error signal ]
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> shellCommand [
	^ shellCommand
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> shellCommand: anObject [
	shellCommand := anObject
]

{ #category : #'OS signal sending' }
GtSubprocessWithInMemoryOutput >> sigterm [
	"Ask the external process to exit cleanly"

	^ process signal: SIGTERM
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> stderr [

	^ stderrStream contents
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> stdout [

	^ stdoutStream contents
]

{ #category : #actions }
GtSubprocessWithInMemoryOutput >> terminate [
	"A conflict of terminology here.
	Pharo process #terminate means kill the process immediately.
	Unix SIGTERM (terminate) means ask the process to exit, running any exit handlers.
	Use the Pharo definition here."

	process kill
]

{ #category : #'system startup & shutdown' }
GtSubprocessWithInMemoryOutput >> terminateOnShutdown [
	"Flag the process for termination if the image quits"

	terminateOnShutdown := true.
	process ifNotNil: [ process terminateOnShutdown ].
]

{ #category : #'api - future' }
GtSubprocessWithInMemoryOutput >> wait [ 
	"Wait for the receiver to finish.
	Only valid when the process was started with #runAndSignal."

	semaphore wait.
	(errorBlock isNotNil and: [ self isSuccess not ])
		ifTrue: [ errorBlock cull: self cull: false ]
]

{ #category : #'api - future' }
GtSubprocessWithInMemoryOutput >> waitTimeoutMSecs: anInteger [
	"Wait for the receiver to finish up anInteger milliSeconds.
	Only valid when the process was started with #runAndSignal."
	| timedOut |

	timedOut := semaphore waitTimeoutMSecs: anInteger.
	(errorBlock isNotNil and: [ timedOut or: [ self isSuccess not ]])
		ifTrue: [ errorBlock cull: self cull: timedOut ]
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> workingDirectory [

	^ builder workingDirectory
]

{ #category : #accessing }
GtSubprocessWithInMemoryOutput >> workingDirectory: aFileReference [

	builder workingDirectory: aFileReference
]
