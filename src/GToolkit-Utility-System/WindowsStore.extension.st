Extension { #name : #WindowsStore }

{ #category : #'*GToolkit-Utility-System' }
WindowsStore >> osCopy: sourcePath to: destinationPath [
	"Copy the source to the destination using the OS utilities.
	Evaluate the appropriate block if the source doesn't exist or the destination does."
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: 'powershell.exe'
		arguments: { 'Copy-Item'. sourcePath. destinationPath. }.
	proc
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock;
		runAndWait.
]
