Class {
	#name : #GtWindowsSystemInfo,
	#superclass : #GtOsSystemInfo,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtWindowsSystemInfo class >> platformName [

	^ 'Win32'
]

{ #category : #'process info' }
GtWindowsSystemInfo >> currentProcessId [

	^ self ffiCall: #(#uint #GetCurrentProcessId #()) module: 'Kernel32.dll'
]

{ #category : #accessing }
GtWindowsSystemInfo >> findExecutable: aString [
	"Do a `where` on the supplied executable name"

	| builder output path lines |

	builder := GtExternalProcessBuilder new
		command: 'where';
		args: { aString asString }.
	output := builder output.
	output status isSuccess
		ifFalse: [ ^ self error: 'Unable to find: ', aString asString ].
	path := output stdout trimBoth.
	path ifEmpty: [ self error: 'Unable to find: ', aString asString ].
	lines := path lines
		collect: [ :line | line trimBoth asFileReference ]
		thenSelect: [ :each | #(bat exe) includes: each extension asLowercase ].
	lines ifEmpty: [ self error: 'Unable to find: ', aString asString ].
	^ lines first.
]

{ #category : #'cpu info' }
GtWindowsSystemInfo >> freeMemory [
	"Answer the free RAM of the host"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'powershell.exe'
		arguments: #('(Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory'))
			errorBlock: [ :ex | self error: 'Unable to retrieve free memory' ];
			runAndWait.
	^ proc stdout asNumber * 1024.
]

{ #category : #'cpu info' }
GtWindowsSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'powershell.exe'
		arguments: #('(Get-WmiObject Win32_Processor).NumberOfCores'))
			errorBlock: [ :ex | self error: 'Unable to retrieve number of cores' ];
			runAndWait.
	^ proc stdout asNumber.
]

{ #category : #'cpu info' }
GtWindowsSystemInfo >> physicalMemory [
	"Answer the RAM capacity of the host"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'powershell.exe'
		arguments: #('(Get-WmiObject Win32_PhysicalMemory).Capacity'))
			errorBlock: [ :ex | self error: 'Unable to retrieve physical memory' ];
			runAndWait.
	^ proc stdout lines inject: 0 into: [ :sum :val | sum + val asNumber ].
]
