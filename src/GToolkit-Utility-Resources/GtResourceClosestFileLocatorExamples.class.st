"
I exemplify {{gtClass:GtResourceClosestFileLocator}}.


"
Class {
	#name : #GtResourceClosestFileLocatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Examples'
}

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> basicLocator [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator |
	aLocator := GtResourceClosestFileLocator new.
	self assert: aLocator file isNil.
	^ aLocator
]

{ #category : #'examples - file locator parent' }
GtResourceClosestFileLocatorExamples >> fileLocator_Parent_OneSubDirectory [
	<gtExample>
	<return: #FileLocator>
	| aChild aParent |
	aChild := FileLocator documents / 'dir1'.
	aParent := aChild parent.

	self assert: aParent path equals: Path workingDirectory.
	self assert: aParent origin equals: aChild origin.

	^ aParent
]

{ #category : #'examples - file locator parent' }
GtResourceClosestFileLocatorExamples >> fileLocator_Parent_TwoSubDirectories [
	<gtExample>
	<return: #FileLocator>
	| aChild aParent |
	aChild := FileLocator documents / 'dir1' / 'dir2'.
	aParent := aChild parent.

	self assert: aParent path equals: Path * 'dir1'.
	self assert: aParent origin equals: aChild origin.

	^ aParent
]

{ #category : #'examples - file locator parent' }
GtResourceClosestFileLocatorExamples >> fileLocator_Parent_ZeroSubDirectories [
	<gtExample>
	<return: #FileLocator>
	| aChild aParent |
	aChild := FileLocator documents.
	aParent := aChild parent.

	(aParent isKindOf: FileLocator)
		ifTrue: [ self assert: aParent path equals: Path workingDirectory.
			self assert: aParent origin ~= aChild origin ]
		ifFalse: [ self assert: aParent equals: aChild resolve parent ].

	^ aParent
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_imageDirectory_pointingToLocalDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator aPath |
	aLocator := self basicLocator.

	aPath := FileLocator localDirectory relativeTo: FileLocator imageDirectory.
	anOriginaFileReference := FileLocator imageDirectory withPath: aPath.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	self
		assert: aTransformedFileLocator origin
		equals: FileLocator localDirectory origin.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_imageDirectory_pointingToLocalDirectoryChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator aPath |
	aLocator := self basicLocator.

	aPath := FileLocator localDirectory relativeTo: FileLocator imageDirectory.
	anOriginaFileReference := (FileLocator imageDirectory withPath: aPath)
			/ 'dir1/file1.txt'.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	self
		assert: aTransformedFileLocator origin
		equals: FileLocator localDirectory origin.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_localDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := FileLocator localDirectory.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self assert: aTransformedFileLocator == anOriginaFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_localDirectoryChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := FileLocator localDirectory / 'dir1' / 'file1.txt'.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_vmDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := FileLocator vmDirectory.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	FileLocator imageDirectory asFileReference
		= FileLocator vmDirectory asFileReference
		ifTrue: [ self
				assert: aTransformedFileLocator origin
				equals: FileLocator imageDirectory origin ].

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_gtResource_FileReferenceChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := (FileLocator gtResource / 'dir1' / 'file1.txt')
			asFileReference fileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (anOriginaFileReference asFileReference
				= aTransformedFileLocator asFileReference
				or: [ anOriginaFileReference asFileReference
						= aTransformedFileLocator asFileReference fileReference ])
		description: [ 'Original file reference '
				, anOriginaFileReference fullPrintString
				, ' must be equal to transformed file locator '
				, aTransformedFileLocator fullPrintString ].

	self
		assert: (aTransformedFileLocator asFileReference
				= anOriginaFileReference asFileReference
				or: [ aTransformedFileLocator asFileReference fileReference
						= anOriginaFileReference asFileReference ])
		description: [ 'Transformed file locator '
				, aTransformedFileLocator fullPrintString
				, ' must be equal to original file reference '
				, anOriginaFileReference fullPrintString ].

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_gtResource_ResourceReferenceChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginalResourceFile aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginalResourceFile := (FileLocator gtResource / 'dir1' / 'file1.txt')
			asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginalResourceFile;
			transform.

	self
		assert: anOriginalResourceFile asFileReference
		equals: aTransformedFileLocator asFileReference.

	self
		assert: anOriginalResourceFile asFileReference
		equals: aTransformedFileLocator asFileReference.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginalResourceFile asFileReference fileReference.

	aTransformedFileLocator asFileReference class = FileReference
		ifTrue: [ self
				assert: (aTransformedFileLocator asFileReference
						= anOriginalResourceFile asFileReference) not ]
		ifFalse: [ self
				assert: aTransformedFileLocator asFileReference
				equals: anOriginalResourceFile asFileReference ].

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_localDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := FileLocator localDirectory asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self assert: (aTransformedFileLocator == anOriginaFileReference) not.
	self assert: aTransformedFileLocator equals: FileLocator localDirectory.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_localDirectoryChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := (FileLocator localDirectory / 'dir1' / 'file1.txt')
			asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_rootDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := '/' asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self assert: anOriginaFileReference == aTransformedFileLocator.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_rootDirectoryChild [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := '/dir1/file1.txt' asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self assert: anOriginaFileReference == aTransformedFileLocator.

	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_vmDirectory [
	<gtExample>
	<return: #GtResourceClosestFileLocator>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := FileLocator vmDirectory asFileReference.
	aTransformedFileLocator := aLocator
			file: anOriginaFileReference;
			transform.

	self
		assert: aTransformedFileLocator asFileReference
		equals: anOriginaFileReference asFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	FileLocator imageDirectory asFileReference
		= FileLocator vmDirectory asFileReference
		ifTrue: [ self
				assert: aTransformedFileLocator origin
				equals: FileLocator imageDirectory origin ].

	^ aLocator
]

{ #category : #'examples - transformed file' }
GtResourceClosestFileLocatorExamples >> transformedFileLocator_withClosestFileLocator [
	<gtExample>
	<return: #FileLocator>
	| anOriginaFileReference aTransformedFileLocator |
	anOriginaFileReference := FileLocator localDirectory.
	aTransformedFileLocator := anOriginaFileReference
			gtWithClosestFileLocatorParent.

	self assert: aTransformedFileLocator == anOriginaFileReference.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aTransformedFileLocator
]

{ #category : #'examples - transformed file' }
GtResourceClosestFileLocatorExamples >> transformedFileReference_withClosestFileLocator [
	<gtExample>
	<return: #FileLocator>
	| anOriginaFileReference aTransformedFileLocator |
	anOriginaFileReference := FileLocator localDirectory asFileReference.
	aTransformedFileLocator := anOriginaFileReference
			gtWithClosestFileLocatorParent.

	self assert: (aTransformedFileLocator == anOriginaFileReference) not.
	self assert: aTransformedFileLocator equals: FileLocator localDirectory.

	self
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aTransformedFileLocator
]
