Extension { #name : #UnixStore }

{ #category : #'*GToolkit-Utility-System' }
UnixStore >> osCopy: sourcePath to: destinationPath [
	"Copy the source to the destination using the OS utilities.
	Evaluate the appropriate block if the source doesn't exist or the destination does."
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: 'cp'
		arguments: {
			'-p'.
			sourcePath fullName.
			destinationPath fullName. }.
	proc
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock;
		runAndWait.
]
