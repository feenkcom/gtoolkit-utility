"
GToolkitUtilitySystemExtensionExamples proves examples to some of the extensions added by the package.
"
Class {
	#name : #GToolkitUtilitySystemExtensionExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GToolkitUtilitySystemExtensionExamples >> osCopyTo [
	"Demonstrate copying a file using the OS utilities"
	<gtExample>
	| srcFile dstFile |

	srcFile := FileReference newTempFilePrefix: 'GToolkit-Utiltiy-System' suffix: '-test.txt'.
	self deny: srcFile exists
		description: [ srcFile fullName, ' exists before creation' ].
	dstFile := FileReference newTempFilePrefix: 'GToolkit-Utiltiy-System' suffix: '-test.txt'.
	[ srcFile writeStreamDo: [ :stream |
		stream print: DateAndTime now ].
	self deny: dstFile exists
		description: [ dstFile fullName, ' exists before creation' ].
	srcFile osCopyTo: dstFile.
	self assert: dstFile exists
		description: [ 'osCopyTo: dstFile doesn''t exist' ].
	self assert: srcFile size equals: dstFile size. ]
		ensure:
			[ srcFile ensureDelete.
			dstFile ensureDelete ].
]
