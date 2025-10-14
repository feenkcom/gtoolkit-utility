Extension { #name : #DoubleLinkedList }

{ #category : #'*GToolkit-Utility-System' }
DoubleLinkedList >> checkIntegrity [
	"Validate that the receiver looks OK.
	Assumes that the receiver is not modified while running the check."
	| currentLink previousLink |

	self isEmpty ifTrue: [ ^ self ].

	"If the receiver is not empty, neither head nor tail should be nil"
	self assert: head isNotNil
		description: 'Not empty, but head is nil'.
	self assert: tail isNotNil
		description: 'Not empty, but tail is nil'.

	self assert: head hasPredecessor not.
	self assert: tail hasSuccessor not.

	currentLink := head.
	previousLink := nil.
	[ currentLink nextLink isNotNil ] whileTrue:
		[ self assert: currentLink previousLink == previousLink
			description: 'previousLink broken'.
		previousLink := currentLink.
		currentLink := currentLink nextLink. ].
	self assert: currentLink == tail
		description: 'last link is not tail'.
]

{ #category : #'*GToolkit-Utility-System' }
DoubleLinkedList >> hasIntegrity [
	"Answer a boolean indicating the receiver looks OK.
	Assumes that the receiver is not modified while running the check."

	^ [ self checkIntegrity.
		true ]
			on: AssertionFailure
			do: [ :ex | false ]
]
