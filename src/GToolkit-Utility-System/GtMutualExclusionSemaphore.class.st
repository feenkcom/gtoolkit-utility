"
GtMutualExclusionSemaphore records the process that owns the receiver, simplifying tracking down deadlocks.

While the semaphore is locked the Stack view shows the stack trace of the owning process.
"
Class {
	#name : #GtMutualExclusionSemaphore,
	#superclass : #Semaphore,
	#instVars : [
		'process'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'mutual exclusion' }
GtMutualExclusionSemaphore >> critical: aBlock [
	"Evaluate the block as in the superclass, but record the owning process"
	| blockValue |

	(process isNotNil and: [ process = Processor activeProcess ]) ifTrue:
		[ self error: 'About to deadlock mutual exclusion semaphore' ].

	super critical:
		[ process := Processor activeProcess.
		blockValue := aBlock value.
		process := nil ].
	^ blockValue
]

{ #category : #accessing }
GtMutualExclusionSemaphore >> gtStackFor: aView [
	<gtView>

	process ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stack';
		priority: 10;
		object: [ process suspendedContext ];
		view: #gtStackFor:
]
