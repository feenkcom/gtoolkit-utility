"
OSSUnixSubprocessss is a convenience wrapper around OSSUnixSubprocess for the common case of executing a command and capturing stdout and stderr, which are strings and are larger than one OS buffer, but small enough to fit in RAM.

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

   One simple example is simply gorgeous.
 
1. # Internal Representation and Key Implementation Points.


1. ## Instance Variables

	arguments:		<Array>
	command:			<String>
	errorBlock:		<BlockClosure>
	process:			<OSSUnixSubprocess>
	semaphore:		<Semaphore>
	stderr:			<String>
	stdout:			<String>


1. ## Implementation Points


"
Class {
	#name : #GtUnixSubprocess,
	#superclass : #Object,
	#instVars : [
		'command',
		'arguments',
		'shellCommand',
		'process',
		'semaphore',
		'stdout',
		'stderr',
		'errorBlock',
		'workingDirectory'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtUnixSubprocess class >> command: cmd arguments: args [

	^self new
		command: cmd;
		arguments: args.
]

{ #category : #accessing }
GtUnixSubprocess >> arguments [
	^ arguments
]

{ #category : #accessing }
GtUnixSubprocess >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtUnixSubprocess >> command [
	^ command
]

{ #category : #accessing }
GtUnixSubprocess >> command: anObject [
	command := anObject
]

{ #category : #accessing }
GtUnixSubprocess >> errorBlock [
	^ errorBlock
]

{ #category : #accessing }
GtUnixSubprocess >> errorBlock: anObject [
	errorBlock := anObject
]

{ #category : #status }
GtUnixSubprocess >> exitStatusInterpreter [

	^ process exitStatusInterpreter
]

{ #category : #accessing }
GtUnixSubprocess >> isSuccess [
	"Answer whether the command completed successfully.
	Only valid after the command has completed."
	
	^process exitStatusInterpreter isSuccess
]

{ #category : #printing }
GtUnixSubprocess >> printOn: aStream [

	process ifNil: [ ^super printOn: aStream ].
	process isRunning ifTrue:
		[ aStream nextPutAll: 'a Running AKGUnixSubprocess' ]
	ifFalse:
		[ self isSuccess ifTrue: 
				[ aStream nextPutAll: 'a Successfull AKGUnixSubprocess' ]
			ifFalse:
				[ aStream nextPutAll: 'an Unsuccessfull AKGUnixSubprocess' ] ].
]

{ #category : #accessing }
GtUnixSubprocess >> process [

	^ process ifNil: [ process := OSSUnixSubprocess new ]
]

{ #category : #removing }
GtUnixSubprocess >> removeLD_LIBRARY_PATH [
	"The script for running pharo sets LD_LIBRARY_PATH to the VM directory, which contains non-standard libraries.
	Unset LD_LIBRARY_PATH."

	self process addAllEnvVariablesFromParentWithoutOverride.
	self process envVariables removeKey: 'LD_LIBRARY_PATH'.
]

{ #category : #running }
GtUnixSubprocess >> run [
	"Run the command without waiting"

	semaphore := nil.
	^self runProcess
]

{ #category : #running }
GtUnixSubprocess >> runAndWait [
	"Run the command and wait for completion"

	semaphore := Semaphore new.
	self runProcess.
	semaphore wait.
	(errorBlock isNotNil and: [ self isSuccess not ])
		ifTrue: [ errorBlock value: self ]
]

{ #category : #private }
GtUnixSubprocess >> runProcess [
	"Run the requested command as a separate process"
	| stdoutStream stderrStream |

	self setCommand.
	stdoutStream := String new writeStream.
	stderrStream := String new writeStream.
	self process
		redirectStdout;
		redirectStderr.
	workingDirectory ifNotNil: 
		[ self process workingDirectory: workingDirectory fullName ].
	self process run.

	[ self process
		waitForExitPollingEvery: (Delay forMilliseconds: 500)
		doing: [ :proc :outStream :errStream | 
			stdoutStream nextPutAll: outStream upToEnd.
			stderrStream nextPutAll: errStream upToEnd ].
	self process closeAndCleanStreams.
	stdout := stdoutStream contents.
	stderr := stderrStream contents.
	"Async processes have errors signalled here.
	If waiting, raise the error after signalling the semaphore (in #runAndWait)"
	semaphore
		ifNil: [ (errorBlock isNotNil and: [ self isSuccess not ])
				ifTrue: [ errorBlock value: self ] ]
		ifNotNil: [ semaphore signal ] ] fork.

]

{ #category : #private }
GtUnixSubprocess >> setCommand [
	"Set the command or shell command in the process.
	Either may be specified, but not both :-)"

	(command isNil and: [ shellCommand isNil ]) ifTrue: 
		[ self error: 'No command supplied' ].
	(command isNotNil and: [ shellCommand isNotNil ]) ifTrue: 
		[ self error: 'Only one of a command or shell command may be supplied' ].

	command ifNil: 
		[ self process shellCommand: shellCommand ]
	ifNotNil:
		[ self process
			command: command;
			arguments: arguments ].

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
	"Ask the external process to terminate"

	^process sigterm
]

{ #category : #accessing }
GtUnixSubprocess >> stderr [
	^ stderr
]

{ #category : #accessing }
GtUnixSubprocess >> stdout [
	^ stdout
]

{ #category : #accessing }
GtUnixSubprocess >> workingDirectory [
	^ workingDirectory
]

{ #category : #accessing }
GtUnixSubprocess >> workingDirectory: aFileReference [

	workingDirectory := aFileReference asFileReference
]
