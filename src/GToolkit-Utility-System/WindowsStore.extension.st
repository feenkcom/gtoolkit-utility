Extension { #name : #WindowsStore }

{ #category : #'*GToolkit-Utility-System' }
WindowsStore >> directoryAt: aPath nodesDo: aBlock [

	| mask drive node |

	aPath isRoot ifFalse: [ ^super directoryAt: aPath nodesDo: aBlock ].
	(aPath isNetworkPath and: [ aPath isRoot ]) ifTrue:
		[ self error: 'Unable to enumerate the root directory of a network path' ].

	mask := File primLogicalDrives.
	0 to: 25 do: [ :i |
		(mask bitAnd: (1 bitShift: i)) ~= 0 ifTrue: [
			drive := String with: (Character value: ($A asciiValue + i)) with: $:.
			node := Array
				with: drive
				with: drive asFileReference entry statAttributes.
			aBlock value: node.
			]
		]
]

{ #category : #'*GToolkit-Utility-System' }
WindowsStore >> osCopy: sourcePath to: destinationPath [
	"Copy the source to the destination using the OS utilities.
	Evaluate the appropriate block if the source doesn't exist or the destination does."
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: 'powershell.exe'
		arguments: {
			'Copy-Item'.
			String streamContents: [ :stream | sourcePath printOn: stream delimiter: $\ ].
			String streamContents: [ :stream | destinationPath printOn: stream delimiter: $\ ]}.
	proc
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock;
		runAndWait
]
