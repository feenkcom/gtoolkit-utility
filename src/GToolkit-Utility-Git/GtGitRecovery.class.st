Class {
	#name : #GtGitRecovery,
	#superclass : #Object,
	#instVars : [
		'repository',
		'mainBranch',
		'saveImage',
		'repositoryName',
		'mainBranchName'
	],
	#category : #'GToolkit-Utility-Git'
}

{ #category : #accessing }
GtGitRecovery >> checkoutMain [
	"Checkout the main branch and load already loaded packages"

	self mainBranch checkout
]

{ #category : #accessing }
GtGitRecovery >> imageCommit [

	^ self workingCopy referenceCommit
]

{ #category : #accessing }
GtGitRecovery >> imageHash [

	^ self imageCommit id.
]

{ #category : #accessing }
GtGitRecovery >> initialize [

	super initialize.
	mainBranchName := 'main'.
	saveImage := true.
]

{ #category : #accessing }
GtGitRecovery >> mainBranch [
	^ mainBranch ifNil: [ mainBranch := self repository branchNamed: mainBranchName ]
]

{ #category : #accessing }
GtGitRecovery >> mainBranchName [
	^ mainBranchName
]

{ #category : #accessing }
GtGitRecovery >> mainBranchName: anObject [
	mainBranchName := anObject
]

{ #category : #accessing }
GtGitRecovery >> recover [

	self subclassResponsibility
]

{ #category : #accessing }
GtGitRecovery >> repository [
	^ repository ifNil: [ repository := IceRepository registry 
		detect: [ :each | each name = repositoryName ] ]
]

{ #category : #accessing }
GtGitRecovery >> repositoryHash [

	^ self repository headCommit id.
]

{ #category : #accessing }
GtGitRecovery >> repositoryName [
	^ repositoryName
]

{ #category : #accessing }
GtGitRecovery >> repositoryName: anObject [
	repositoryName := anObject
]

{ #category : #accessing }
GtGitRecovery >> saveImage [

	^ saveImage
]

{ #category : #accessing }
GtGitRecovery >> saveImage: aBoolean [
	saveImage := aBoolean
]

{ #category : #accessing }
GtGitRecovery >> saveImageNoSnapshot [

	saveImage ifTrue:
		[ Smalltalk snapshot: true andQuit: false ]
]

{ #category : #accessing }
GtGitRecovery >> workingCopy [

	^ self repository workingCopy
]
