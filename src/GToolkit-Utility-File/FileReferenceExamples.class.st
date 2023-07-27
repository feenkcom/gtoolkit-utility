Class {
	#name : #FileReferenceExamples,
	#superclass : #AbstractFileReferenceExamples,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
FileReferenceExamples >> workingDirectory [
	| aReference |
	aReference := FileLocator workingDirectory asFileReference.

	self assert: (aReference isKindOf: FileReference).

	^ aReference
]
