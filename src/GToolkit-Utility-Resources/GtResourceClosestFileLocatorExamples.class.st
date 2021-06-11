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
	| aLocator |
	aLocator := GtResourceClosestFileLocator new.
	self assert: aLocator file isNil.
	^ aLocator
]

{ #category : #'examples - file locator parent' }
GtResourceClosestFileLocatorExamples >> fileLocator_Parent_OneSubDirectory [
	<gtExample>
	
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
	
	| aChild aParent |
	aChild := (FileLocator documents / 'dir1' / 'dir2').
	aParent := aChild parent.
	
	self assert: aParent path equals: Path * 'dir1'.
	self assert: aParent origin equals: aChild origin.
	
	^ aParent
]

{ #category : #'examples - file locator parent' }
GtResourceClosestFileLocatorExamples >> fileLocator_Parent_ZeroSubDirectories [
	<gtExample>
	
	| aChild aParent |
	aChild := FileLocator documents.
	aParent := aChild parent.
	
	(aParent isKindOf: FileLocator)
		ifTrue: [ 
			self assert: aParent path equals: Path workingDirectory.
			self assert: aParent origin ~= aChild origin ]
		ifFalse: [ 
			self assert: aParent equals: aChild resolve parent ].
	
	^ aParent
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileLocator_imageDirectory_pointingToLocalDirectory [
	<gtExample>
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
	| aLocator anOriginaFileReference aTransformedFileLocator aPath |
	aLocator := self basicLocator.
	
	aPath := FileLocator localDirectory relativeTo: FileLocator imageDirectory.	
	anOriginaFileReference := (FileLocator imageDirectory withPath: aPath) / 'dir1/file1.txt'.
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

	FileLocator imageDirectory asFileReference = FileLocator vmDirectory asFileReference 
		ifTrue: [	
			self 
				assert: aTransformedFileLocator origin 
				equals: FileLocator imageDirectory origin ].
	
	^ aLocator
]

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> locator_FileReference_gtResourceChild [
	<gtExample>
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := (FileLocator gtResource / 'dir1' / 'file1.txt') asFileReference.
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
GtResourceClosestFileLocatorExamples >> locator_FileReference_localDirectory [
	<gtExample>
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
	| aLocator anOriginaFileReference aTransformedFileLocator |
	aLocator := self basicLocator.
	anOriginaFileReference := (FileLocator localDirectory / 'dir1' / 'file1.txt') asFileReference.
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

	FileLocator imageDirectory asFileReference = FileLocator vmDirectory asFileReference 
		ifTrue: [	
			self 
				assert: aTransformedFileLocator origin 
				equals: FileLocator imageDirectory origin ].
	
	^ aLocator
]

{ #category : #'examples - transformed file' }
GtResourceClosestFileLocatorExamples >> transformedFileLocator_withClosestFileLocator [
	<gtExample>
	| anOriginaFileReference aTransformedFileLocator |
	anOriginaFileReference := FileLocator localDirectory.
	aTransformedFileLocator := anOriginaFileReference gtWithClosestFileLocatorParent.
	
	self assert: aTransformedFileLocator == anOriginaFileReference.

	self 
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aTransformedFileLocator
]

{ #category : #'examples - transformed file' }
GtResourceClosestFileLocatorExamples >> transformedFileReference_withClosestFileLocator [
	<gtExample>
	| anOriginaFileReference aTransformedFileLocator |
	anOriginaFileReference := FileLocator localDirectory asFileReference.
	aTransformedFileLocator := anOriginaFileReference gtWithClosestFileLocatorParent.
	
	self assert: (aTransformedFileLocator == anOriginaFileReference) not.
	self assert: aTransformedFileLocator equals: FileLocator localDirectory.

	self 
		assert: (aTransformedFileLocator isKindOf: FileLocator)
		description: 'The transformed file must be a FileLocator'.

	^ aTransformedFileLocator
]
