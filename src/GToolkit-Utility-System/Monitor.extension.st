Extension { #name : #Monitor }

{ #category : #'*GToolkit-Utility-System' }
Monitor >> assertIsOwner [
	"Assert that the calling process is the owner of the receiver.
	Synonymous with #checkOwnerProcess, for Mutex compatibility."

	self
		assert: self isOwnerProcess
		description: 'Active process is not the Monitor owner'.
]

{ #category : #'*GToolkit-Utility-System' }
Monitor >> assertNotNested [
	"Confirm that the caller owns the receiver and that there aren't nested critical sections."

	self assertIsOwner.
	self assert: nestingLevel = 1
		description: 'nested critical sections'.
]

{ #category : #'*GToolkit-Utility-System' }
Monitor >> critical: aBlock [
	"Critical section.
	Executes aBlock as a critical section. At any time, only one process can be executing code
	in a critical section.
	NOTE: All the following synchronization operations are only valid inside the critical section
	of the monitor!"
	| myProcess blockValue caught |

	myProcess := Processor activeProcess.
	caught := false.
	[ 
	"See Semaphore>>critical: for a description of the structure of the code below."
	myProcess == ownerProcess ifTrue: [
		"Don't move the caught assignment outside the ifTrue:ifFalse, see below"
		caught := true.
		nestingLevel := nestingLevel + 1.
	] ifFalse: [
		"Set caught immediately before the mutex wait to ensure the process isn't interrupted"
		caught := true.
		mutex wait.
		ownerProcess := myProcess.
		nestingLevel := 1.
	].

	blockValue := aBlock value ]
		ensure: [ caught ifTrue: [ self exit ] ].
	^ blockValue
]
