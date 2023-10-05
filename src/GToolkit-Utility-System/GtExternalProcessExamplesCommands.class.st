Class {
	#name : #GtExternalProcessExamplesCommands,
	#superclass : #Object,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #private }
GtExternalProcessExamplesCommands >> echoTestEnvProcess [
	<return: #GtSubprocessWithInMemoryOutput>

	^ GtSubprocessWithInMemoryOutput new
		command: self echoTestEnvScript fullName;
		errorBlock: [ :process | self error: 'Failed to echo env var' ].

]

{ #category : #private }
GtExternalProcessExamplesCommands >> echoTestEnvScript [
	<return: #FileReference>

	^ self subclassResponsibility 
]

{ #category : #private }
GtExternalProcessExamplesCommands >> exitHandlerProcess: aTimeout [
	<return: #GtSubprocessWithInMemoryOutput>
	| process |

	process := GtSubprocessWithInMemoryOutput new
		command: self exitHandlerScript fullName.
	aTimeout ifNotNil: [ process addArgument: aTimeout asString ].
	^ process
]

{ #category : #private }
GtExternalProcessExamplesCommands >> exitHandlerScript [
	"Answer a FileReference pointing to the exithandler script"
	<return: #FileReference>

	^ self subclassResponsibility 
]

{ #category : #private }
GtExternalProcessExamplesCommands >> findScript: scriptName [
	"Answer the script with the supplied name"
	<return: #FileReference>
	| script |

	{ 
		FileLocator localDirectory / 'iceberg' / 'feenkcom' / 'gtoolkit-external-process' / 'tests' / 'scripts'	.
		GtResourcesUtilityConstants localGtDirectory / 'feenkcom' / 'gtoolkit-external-process' / 'tests' / 'scripts'.
	} do: [ :each |
			(script := each / scriptName) exists ifTrue:
				[ ^ script ] ].

	self error: scriptName, ' not found'.
]
