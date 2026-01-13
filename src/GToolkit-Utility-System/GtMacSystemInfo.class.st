Class {
	#name : #GtMacSystemInfo,
	#superclass : #GtOsSystemInfo,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtMacSystemInfo class >> platformName [

	^ 'Mac OS'
]

{ #category : #'process info' }
GtMacSystemInfo >> currentProcessId [

	^ LibC uniqueInstance currentProcessId
]

{ #category : #'cpu info' }
GtMacSystemInfo >> freeMemory [
	"Answer the free RAM of the host in bytes"

	| proc pageSize freePages output inactivePages |
	proc := (GtSubprocessWithInMemoryOutput command: 'vm_stat' arguments: #())
			errorBlock: [ :ex | self error: 'Unable to retrieve free memory' ];
			runAndWait.
	pageSize := self pageSize.
	output := proc stdout.
	freePages := (self colonSeparatedGet: 'Pages free' fromString: output) asNumber.
	inactivePages := (self colonSeparatedGet: 'Pages inactive' fromString: output)
			asNumber.
	^ (freePages + inactivePages) * pageSize
]

{ #category : #'cpu info' }
GtMacSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"
	| proc |

	proc := (GtSubprocessWithInMemoryOutput 
		command: 'sysctl'
		arguments: #('-a' 'machdep.cpu.core_count'))
			errorBlock: [ :ex | self error: 'Unable to retrieve number of cores: ', ex printString ];
			runAndWait.
	^ (self colonSeparatedGet: 'machdep.cpu.core_count' fromString: proc stdout) asNumber.
]

{ #category : #'cpu info' }
GtMacSystemInfo >> pageSize [
	| proc |
	proc := (GtSubprocessWithInMemoryOutput command: 'pagesize' arguments: #())
			errorBlock: [ :ex | self error: 'Unable to retrieve pagesize' ];
			runAndWait.
	^proc stdout asNumber
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
	^ (self colonSeparatedGet: 'hw.memsize' fromString: proc stdout) asNumber.
]

{ #category : #'as yet unclassified' }
GtMacSystemInfo >> userName [

	^ OSEnvironment current 
		at: 'USER'
		ifAbsent: [ nil ]
]
