Class {
	#name : #SqSocketExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-File-Examples'
}

{ #category : #examples }
SqSocketExamples >> closeOnExec [
	"Check that closeOnExec is set by default in sockets,
	and that it can be cleared"
	<gtExample>
	| newSocket |

	newSocket := Socket newTCP.
	self assert: newSocket closeOnExec
		description: 'Socket closeOnExec not set'.
	newSocket closeOnExec: false.
	self deny: newSocket closeOnExec
		description: 'Socket closeOnExec set'.
	newSocket closeAndDestroy.
]
