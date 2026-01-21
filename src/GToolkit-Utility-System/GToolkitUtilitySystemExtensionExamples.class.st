"
GToolkitUtilitySystemExtensionExamples proves examples to some of the extensions added by the package.
"
Class {
	#name : #GToolkitUtilitySystemExtensionExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : 'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GToolkitUtilitySystemExtensionExamples >> gtQuiescentProcesses [
	"Confirm that ProcessorScheduler>>gtQuiescentProcesses includes the expected processes"

	<gtExample>
	<return: #GToolkitUtilitySystemExtensionExamples>
	| currentPriority proc1 proc2 quiescentProcesses |
	"Attempting to step through this in the debugger is bound to end in tears..."
	currentPriority := Processor activeProcess priority.
	proc1 := [ 100 factorial ] forkAt: currentPriority - 1.
	proc2 := [ 100 factorial ] forkAt: currentPriority - 1.
	quiescentProcesses := Processor gtQuiescentProcesses.
	self deny: proc1 isTerminated.
	self deny: proc2 isTerminated.
	self assert: (quiescentProcesses includes: proc1).
	self assert: (quiescentProcesses includes: proc2)
]

{ #category : #examples }
GToolkitUtilitySystemExtensionExamples >> osCopyTo [
	"Demonstrate copying a file using the OS utilities"

	<gtExample>
	<return: #GToolkitUtilitySystemExtensionExamples>
	| srcFile dstFile |
	srcFile := FileReference
			newTempFilePrefix: 'GToolkit-Utiltiy-System'
			suffix: '-test.txt'.
	self
		deny: srcFile exists
		description: [ srcFile fullName , ' exists before creation' ].
	dstFile := FileReference
			newTempFilePrefix: 'GToolkit-Utiltiy-System'
			suffix: '-test.txt'.
	[ srcFile writeStreamDo: [ :stream | stream print: DateAndTime now ].
	self
		deny: dstFile exists
		description: [ dstFile fullName , ' exists before creation' ].
	srcFile osCopyTo: dstFile.
	self assert: dstFile exists description: [ 'osCopyTo: dstFile doesn''t exist' ].
	self assert: srcFile size equals: dstFile size ]
		ensure: [ srcFile ensureDelete.
			dstFile ensureDelete ]
]
