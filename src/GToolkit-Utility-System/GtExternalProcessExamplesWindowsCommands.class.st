Class {
	#name : #GtExternalProcessExamplesWindowsCommands,
	#superclass : #GtExternalProcessExamplesCommands,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> echoTestEnvProcess [

	^ GtUnixSubprocess new
		command: self echoTestEnvScript fullName.

]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> echoTestEnvScript [
	"Answer the command to be used for echoing the test environment variable."
	<return: #FileReference>

	^ self findScript: 'echotestenv.bat'.
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> exitHandlerProcess: aTimeout [
	| process |

	process := GtUnixSubprocess new
		command: self exitHandlerScript fullName.
	aTimeout ifNotNil: [ process arg: aTimeout asString ].
	^ process
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> exitHandlerScript [
	"Answer a FileReference pointing to exithandler.sh"
	<return: #FileReference>

	^ self findScript: 'exithandler.bat'.
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> failProcess [
	"Answer a command that returns failure, i.e. exit code ~= 0"

	^ self sleepProcess arguments: #('-1')
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> pwdCommand [
	"Answer the command to be used for printing the working directory."

	^ (self findScript: 'pwd.bat') fullName
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> sleepCommand [
	"Answer the command to be used for sleeping the specified time.
	On Windows the exitHandlerScript provides the required functionality"

	^ self exitHandlerScript fullName
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> sleepProcess [
	"Answer a partially configured process tp sleep the specified time"

	^ GtUnixSubprocess new
		command: self sleepCommand
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> successProcess [
	"Answer a command that returns failure, i.e. exit code = 0"

	^ self sleepProcess
]
