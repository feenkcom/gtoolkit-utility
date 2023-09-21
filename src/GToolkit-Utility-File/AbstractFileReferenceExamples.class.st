Class {
	#name : #AbstractFileReferenceExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #testing }
AbstractFileReferenceExamples class >> isAbstract [
	^ self name = #AbstractFileReferenceExamples
]

{ #category : #accessing }
AbstractFileReferenceExamples >> rootDirectory [
	^ self subclassResponsibility
]

{ #category : #accessing }
AbstractFileReferenceExamples >> rootDirectoryChild [
	^ self rootDirectory / 'child'
]

{ #category : #accessing }
AbstractFileReferenceExamples >> rootDirectoryParent [
	^ self rootDirectory / '..'
]

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_rootDirectory [
	<gtExample>
	| aReference aResult |
	aReference := self rootDirectory.
	aResult := aReference withParents.

	self
		assert: aResult isEmpty not
		description: [ 'Root directory collection must be non-empty' ].
		
	self
		assert: aResult size = 1
		description: [ 'Root directory collection must have one item' ].

	^ aResult
]

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_rootDirectoryChild [
	<gtExample>
	| aReference aResult |
	aReference := self rootDirectoryChild.
	aResult := aReference withParents.

	self
		assert: aResult isEmpty not
		description: [ 'Root directory collection must be non-empty' ].
		
	self
		assert: aResult size = 2
		description: [ 'Root directory collection must have two items' ].

	^ aResult
]

{ #category : #accessing }
AbstractFileReferenceExamples >> withParents_rootDirectoryParent [
	<gtExample>
	<noTest>
	| aReference aResult |
	aReference := self rootDirectoryParent.
	aResult := aReference withParents.

	self
		assert: aResult isEmpty
		description: [ 'Root directory parent collection must be empty' ].

	^ aResult
]

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
