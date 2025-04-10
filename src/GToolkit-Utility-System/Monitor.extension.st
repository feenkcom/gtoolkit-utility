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
