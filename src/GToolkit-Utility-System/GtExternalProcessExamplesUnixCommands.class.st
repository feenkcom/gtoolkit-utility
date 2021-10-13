Class {
	#name : #GtExternalProcessExamplesUnixCommands,
	#superclass : #GtExternalProcessExamplesCommands,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> echoTestEnvProcess [

	^ GtUnixSubprocess new
		command: 'bash';
		arguments: { '-c'. self echoTestEnvScript fullName }

]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> echoTestEnvScript [
	"Answer the command to be used for echoing the test environment variable."
	<return: #FileReference>

	^ self findScript: 'echotestenv.sh'.
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> exitHandlerProcess: aTimeout [
	| cmd |

	cmd := aTimeout
		ifNil: [ self exitHandlerScript fullName ]
		ifNotNil: [ self exitHandlerScript fullName, ' ', aTimeout asString ].
	^ GtUnixSubprocess new
		command: 'bash';
		arguments: { '-c'. cmd. }

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

	^ GtUnixSubprocess new
		command: 'false'
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> pwdCommand [
	"Answer the command to be used for printing the working directory."

	^ 'pwd'
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> sleepProcess [
	"Answer a partially configured process tp sleep the specified time"

	^ GtUnixSubprocess new
		command: 'sleep'
]

{ #category : #private }
GtExternalProcessExamplesUnixCommands >> successProcess [
	"Answer a command that returns success, i.e. exit code = 0"

	^ GtUnixSubprocess new
		command: 'true'
]
