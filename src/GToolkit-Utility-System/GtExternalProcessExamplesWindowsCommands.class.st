Class {
	#name : #GtExternalProcessExamplesWindowsCommands,
	#superclass : #GtExternalProcessExamplesCommands,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> echoTestEnvScript [
	"Answer the command to be used for echoing the test environment variable."
	<return: #FileReference>

	^ self findScript: 'echotestenv.bat'.
]

{ #category : #private }
GtExternalProcessExamplesWindowsCommands >> exitHandlerScript [
	"Answer a FileReference pointing to exithandler.sh"
	<return: #FileReference>

	^ self findScript: 'exithandler.bat'.
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
