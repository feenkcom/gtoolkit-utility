Extension { #name : #Process }

{ #category : #'*GToolkit-Utility-Basic' }
Process >> at: priorityInteger do: aBlock [
	"Evaluate aBlock at the specified priority, then return the priority to its current value."
	| oldPriority |

	oldPriority := priority.
	self priority: priorityInteger.
	^ aBlock ensure: [ self priority: oldPriority ].
]
