"
GtUnixSubprocessss is a convenience wrapper around OSSUnixSubprocess for the common case of executing a command and capturing stdout and stderr, which are strings and are larger than one OS buffer, but small enough to fit in RAM.

Typical usage is: 

``` 
proc := (GtUnixSubprocess command: 'ls' arguments: #('-lh'))
proc errorBlock: [ :proc | self error: 'External process failed, see proc' ].
proc runAndWait
proc stdout
```

If no error block is supplied the completion status should be checked with `#isSuccess`.


Public API and Key Messages

- command:arguments: 	(class) create an instance with the supplied parameters
- errorBlock: 			Set the block to be evaluated if the process exits unsuccessfully.
		Note that this is only called if the process is successfully started and subsequently fails.
		Supplying a non-existing path, or a command that can't be found, will raise an error in the calling process.
- removeLD_LIBRARY_PATH: 	Remove LD_LIBRARY_PATH from the environment passed to the subprocess.
		This is useful on linux if the command expects the system installation of openssl.
- runAndWait: 			Execute the command and wait for completion.
- isSuccess 				Answer a boolean indicating if the command completed successfully.
- stdout, stderr: 		The output strings.

 
## Internal Representation and Key Implementation Points.


### Instance Variables

	arguments:		<Array>
	command:			<String>
	errorBlock:		<BlockClosure>
	process:			<OSSUnixSubprocess>
	semaphore:		<Semaphore>
	stderrStream:	<WriteStream on: String>
	stdoutStream:	<WriteStream on: String>


### Implementation Points


"
Class {
	#name : #GtUnixSubprocess,
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
		'outputPoll'
	],
	#pools : [
		'LibCSignalSharedPool'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtUnixSubprocess class >> command: cmd arguments: args [

	^self new
		command: cmd;
		arguments: args.
]

{ #category : #'instance creation' }
GtUnixSubprocess class >> waitOnCommand: aString arguments: anArray [
	| proc |

	proc := self command: aString arguments: anArray.
	proc runAndWait.
	proc isSuccess ifFalse:
		[ self error: 'Completed with Error: ', aString ].
	^ proc
]

{ #category : #adding }
GtUnixSubprocess >> addAllEnvVariablesFromParentWithoutOverride [
	"The user may have done an explicit set of a variable via #environmentAt:put: in which case
	we do not want to override it with the inherit one.
	This method allows to set all but overriden variables inherit from parent."

	"Ensure the dictionary has been set"
	self envVariables.
	Smalltalk os environment asDictionary keysAndValuesDo: [ :key :value |
		envVariables at: key ifAbsentPut: value ].

]

{ #category : #accessing }
GtUnixSubprocess >> arguments [

	^ builder arguments
]

{ #category : #accessing }
GtUnixSubprocess >> arguments: aCollection [

	builder args: aCollection
]

{ #category : #cleaning }
GtUnixSubprocess >> closeAndCleanStreams [
	"This is now a no-op - the library takes care of stream maintenance"
]

{ #category : #accessing }
GtUnixSubprocess >> command [

	^ builder command
]

{ #category : #accessing }
GtUnixSubprocess >> command: aString [

	builder command: aString
]

{ #category : #'env building' }
GtUnixSubprocess >> envVariables [
	"Answer the dictionary of environment variables that will be passed to the sub-process.
	If nil, they are inherited from the parent process (Gt)"

	^ envVariables ifNil: [ envVariables := Dictionary new ]
]

{ #category : #accessing }
GtUnixSubprocess >> environmentAt: key put: value [

	self envVariables at: key put: value.
]

{ #category : #accessing }
GtUnixSubprocess >> errorBlock [
	^ errorBlock
]

{ #category : #accessing }
GtUnixSubprocess >> errorBlock: anObject [
	errorBlock := anObject
]

{ #category : #accessing }
GtUnixSubprocess >> exitCode [ 
	"Answer the interpretted exit status, or nil if not available"

	^ process tryWait ifNotNil: [ :status | status code ]
]

{ #category : #accessing }
GtUnixSubprocess >> exitStatus [ 

	^ self exitCode
]

{ #category : #status }
GtUnixSubprocess >> exitStatusInterpreter [

	^ process tryWait
]

{ #category : #ui }
GtUnixSubprocess >> gtStderrFor: aView [
	<gtView>

	self stderr ifNil: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stderr';
		priority: 20;
		text: [ self stderr asRopedText glamorousCodeFont ];
		actionUpdateButtonTooltip: 'Update stderr'

]

{ #category : #ui }
GtUnixSubprocess >> gtStdoutFor: aView [
	<gtView>

	self stdout ifNil: [ ^ aView empty ].
	^ aView textEditor 
		title: 'stdout';
		priority: 20;
		text: [ self stdout asRopedText glamorousCodeFont ];
		actionUpdateButtonTooltip: 'Update stdout'

]

{ #category : #testing }
GtUnixSubprocess >> hasProcess [
	"Answer a boolean indicating whether the receiver has a process object"

	^ process isNotNil
]

{ #category : #initialization }
GtUnixSubprocess >> initialize [

	super initialize.
	builder := GtExternalProcessBuilder new.

]

{ #category : #testing }
GtUnixSubprocess >> isComplete [

	^ self hasProcess and: 
		[ process isNull not and: 
		[ process isTerminated ] ]
]

{ #category : #testing }
GtUnixSubprocess >> isRunning [ 

	^ self hasProcess and: 
		[ process isNull not and: 
		[ process isTerminated not ] ]
]

{ #category : #testing }
GtUnixSubprocess >> isSuccess [
	"Answer whether the command completed successfully.
	Only valid after the command has completed."

	self isComplete ifFalse: [ self error: 'Process not yet complete' ].
	^ self exitStatusInterpreter isSuccess
]

{ #category : #actions }
GtUnixSubprocess >> kill [

	process kill
]

{ #category : #printing }
GtUnixSubprocess >> printOn: aStream [

	process ifNil: [ ^super printOn: aStream ].
	self isRunning ifTrue:
		[ aStream nextPutAll: 'a Running GtUnixSubprocess' ]
	ifFalse: [ self isComplete ifFalse:
		[ aStream nextPutAll: 'an Incomplete GtUnixSubprocess' ]
	ifTrue:
		[ self isSuccess ifTrue: 
				[ aStream nextPutAll: 'a Successfull GtUnixSubprocess' ]
			ifFalse:
				[ aStream nextPutAll: 'an Unsuccessfull GtUnixSubprocess' ] ] ].
]

{ #category : #accessing }
GtUnixSubprocess >> process [

	^ process
]

{ #category : #status }
GtUnixSubprocess >> queryExitStatus [

	^ process queryExitStatus
]

{ #category : #removing }
GtUnixSubprocess >> removeLD_LIBRARY_PATH [
	"The script for running pharo sets LD_LIBRARY_PATH to the VM directory, which contains non-standard libraries.
	Unset LD_LIBRARY_PATH."

	self addAllEnvVariablesFromParentWithoutOverride.
	self envVariables removeKey: 'LD_LIBRARY_PATH' ifAbsent: 
		[ "No need to do anything if LD_LIBRARY_PATH is absent" ].
]

{ #category : #running }
GtUnixSubprocess >> run [
	"Run the command without waiting"

	semaphore := nil.
	^ self runProcess
]

{ #category : #running }
GtUnixSubprocess >> runAndSignal [
	"Run the command without waiting, but signal the semaphore when done"

	semaphore := Semaphore new.
	self runProcess
]

{ #category : #running }
GtUnixSubprocess >> runAndWait [
	"Run the command and wait for completion"

	self runAndSignal.
	self wait.

]

{ #category : #private }
GtUnixSubprocess >> runProcess [
	"Run the requested command as a separate process"

	self setCommand.
	command := builder createNativeCommand.
	command 
		pipeStdout;
		pipeStderr.
	envVariables ifNotNil: 
		[ command clearEnv.
		envVariables keysAndValuesDo: [ :key :value |
			command setEnv: key value: value ] ].
	process := command spawn.
	stdoutStream := String new writeStream.
	stderrStream := String new writeStream.
	stdoutBuffer := process asynchronousStdout.
	stderrBuffer := process asynchronousStderr.

	outputPoll := 
		[ process waitForExitDoing: 
				[ stdoutStream nextPutAll: stdoutBuffer pollString.
				stderrStream nextPutAll: stderrBuffer pollString ].
		"Async processes have errors signalled here.
		If waiting, raise the error after signalling the semaphore (in #runAndWait)"
		semaphore
			ifNil: [ (errorBlock isNotNil and: [ self isSuccess not ])
					ifTrue: [ errorBlock value: self ] ]
			ifNotNil: [ semaphore signalAll ] ] forkAt: Processor activeProcess priority + 1.

]

{ #category : #private }
GtUnixSubprocess >> setCommand [
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

{ #category : #accessing }
GtUnixSubprocess >> shellCommand [
	^ shellCommand
]

{ #category : #accessing }
GtUnixSubprocess >> shellCommand: anObject [
	shellCommand := anObject
]

{ #category : #'OS signal sending' }
GtUnixSubprocess >> sigterm [
	"Ask the external process to exit cleanly"

	^ process signal: SIGTERM
]

{ #category : #accessing }
GtUnixSubprocess >> stderr [

	^ stderrStream contents
]

{ #category : #accessing }
GtUnixSubprocess >> stdout [

	^ stdoutStream contents
]

{ #category : #actions }
GtUnixSubprocess >> terminate [
	"A conflict of terminology here.
	Pharo process #terminate means kill the process immediately.
	Unix SIGTERM (terminate) means ask the process to exit, running any exit handlers.
	Use the Pharo definition here."

	process kill
]

{ #category : #'system startup & shutdown' }
GtUnixSubprocess >> terminateOnShutdown [

	self process terminateOnShutdown
]

{ #category : #'api - future' }
GtUnixSubprocess >> wait [ 
	"Wait for the receiver to finish.
	Only valid when the process was started with #runAndSignal."

	semaphore wait.
	(errorBlock isNotNil and: [ self isSuccess not ])
		ifTrue: [ errorBlock value: self ]
]

{ #category : #accessing }
GtUnixSubprocess >> workingDirectory [

	^ builder workingDirectory
]

{ #category : #accessing }
GtUnixSubprocess >> workingDirectory: aFileReference [

	builder workingDirectory: aFileReference
]
