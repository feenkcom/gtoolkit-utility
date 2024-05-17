Extension { #name : #ProcessorScheduler }

{ #category : #'*GToolkit-Utility-System' }
ProcessorScheduler >> gtQuiescentProcesses [
	"Answer the collection of quiescent processes, with the preempted process first.
	This method is typically called from a high-priority process while gathering information for debugging."
	| processes preemptedProcess currentProcess |

	processes := OrderedCollection new.
	preemptedProcess := self preemptedProcess.
	processes add: preemptedProcess.
	quiescentProcessLists reverseDo: [ :list |
		currentProcess := list firstOrNil.
		[ currentProcess isNil ] whileFalse: 
			[ currentProcess == preemptedProcess ifFalse:
				[ processes add: currentProcess ].
			currentProcess := currentProcess nextLink ] ].
	^ processes.
]
