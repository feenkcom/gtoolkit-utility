Class {
	#name : #AbstractFileReferenceExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_workingDirectory [
	<gtExample>
	| aReference aResult |
	aReference := self workingDirectory.
	aResult := aReference withParents.

	self
		assert: aResult isEmpty not
		description: [ 'Parents collection must be non-empty' ].

	^ aResult
]

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_workingDirectoryParent [
	<gtExample>
	| aParentReference aParentResult aChildResult |
	aParentReference := self workingDirectoryParent.
	aParentResult := aParentReference withParents.
	
	aChildResult := self withParents_workingDirectory.

	self
		assert: aParentResult isEmpty not
		description: [ 'Parents collection must be non-empty' ].
		
	self assert: aParentResult size equals: aChildResult size - 1.
	self assert: aParentResult last equals: (aChildResult at: aChildResult size - 1).

	^ aParentResult
]

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_workingDirectoryParentParent [
	<gtExample>
	| aParentReference aParentResult aChildResult |
	aParentReference := self workingDirectoryParentParent.
	aParentResult := aParentReference withParents.
	
	aChildResult := self withParents_workingDirectoryParent.

	self
		assert: aParentResult isEmpty not
		description: [ 'Parents collection must be non-empty' ].
		
	self assert: aParentResult size equals: aChildResult size - 1.
	self assert: aParentResult last equals: (aChildResult at: aChildResult size - 1).

	^ aParentResult
]

{ #category : #accessing }
AbstractFileReferenceExamples >> workingDirectory [
	^ self subclassResponsibility
]

{ #category : #accessing }
AbstractFileReferenceExamples >> workingDirectoryParent [
	^ self workingDirectory parent
]

{ #category : #accessing }
AbstractFileReferenceExamples >> workingDirectoryParentParent [
	^ self workingDirectoryParent parent
]
