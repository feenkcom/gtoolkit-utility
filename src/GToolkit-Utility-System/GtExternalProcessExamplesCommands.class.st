Class {
	#name : #GtExternalProcessExamplesCommands,
	#superclass : #Object,
	#category : #'GToolkit-Utility-System-Examples'
}

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
