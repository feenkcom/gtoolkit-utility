Class {
	#name : #GtExternalProcessExamplesUnixCommands,
	#superclass : #GtExternalProcessExamplesCommands,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> echoTestEnvScript [
	"Answer the command to be used for echoing the test environment variable."
	<return: #FileReference>

	^ self findScript: 'echotestenv.sh'.
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> exitHandlerScript [
	"Answer a FileReference pointing to exithandler.sh"
	<return: #FileReference>

	^ self findScript: 'exithandler.sh'.
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> failProcess [
	"Answer a command that returns failure, i.e. exit code ~= 0"

	^ GtSubprocessWithInMemoryOutput new
		command: 'false'
]

{ #category : #initialization }
GtExternalProcessExamplesUnixCommands >> initialize [ 
	| scriptDir |

	super initialize.
	scriptDir := self exitHandlerScript parent.
	GtSubprocessWithInMemoryOutput new
		shellCommand: 'chmod +x ', scriptDir fullName, '/*.sh';
		errorBlock: [ :proc | self error: 'Failed to set executable bit' ];
		runAndWait.
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> pwdCommand [
	"Answer the command to be used for printing the working directory."

	^ 'pwd'
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> sleepProcess [
	"Answer a partially configured process tp sleep the specified time"

	^ GtSubprocessWithInMemoryOutput new
		command: 'sleep'
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> successProcess [
	"Answer a command that returns success, i.e. exit code = 0"

	^ GtSubprocessWithInMemoryOutput new
		command: 'true'
]
