"
I exemplify ${class:GtResourceClosestFileLocator}$.
"
Class {
	#name : #GtResourceClosestFileLocatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Core'
}

{ #category : #'examples - locator' }
GtResourceClosestFileLocatorExamples >> basicLocator [
	<gtExample>
	| aLocator |
	aLocator := GtResourceClosestFileLocator new.
	self assert: aLocator file isNil.
	^ aLocator
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
