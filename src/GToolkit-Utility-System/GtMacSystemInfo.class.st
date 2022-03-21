Class {
	#name : #GtMacSystemInfo,
	#superclass : #GtOsSystemInfo,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtMacSystemInfo class >> platformName [

	^ #'Mac OS'
]

{ #category : #'cpu info' }
GtMacSystemInfo >> freeMemory [
	"Answer the free RAM of the host in bytes"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'vm_stat'
		arguments: #())
			errorBlock: [ :ex | self error: 'Unable to retrieve free memory' ];
			runAndWait.
	^ (self colonSeparatedGet: 'Pages free' fromString: proc stdout) asNumber * 4096.
]

{ #category : #'cpu info' }
GtMacSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'sysctl'
		arguments: #('-a' 'machdep.cpu.core_count'))
			errorBlock: [ :ex | self error: 'Unable to retrieve number of cores' ];
			runAndWait.
	^ proc stdout asNumber.
]

{ #category : #'cpu info' }
GtMacSystemInfo >> physicalMemory [
	"Answer the RAM capacity of the host in bytes"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'sysctl'
		arguments: #('-a' 'hw.memsize'))
			errorBlock: [ :ex | self error: 'Unable to retrieve physical memory' ];
			runAndWait.
	^ proc stdout asNumber.
]
