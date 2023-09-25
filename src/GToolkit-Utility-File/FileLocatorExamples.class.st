Class {
	#name : #FileLocatorExamples,
	#superclass : #AbstractFileReferenceExamples,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
FileLocatorExamples >> rootDirectory [
	^ FileLocator root
]

{ #category : #accessing }
FileLocatorExamples >> workingDirectory [
	^ FileLocator workingDirectory asFileReference
]
