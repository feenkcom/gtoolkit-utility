"
GtGitRecoverDetachedWithUncommittedChanges attempts to recover from the situation where a repository is in ""Detached Working Copy"" state and there are changes to the repository in the image.

The sequence of events is to:

1. Save the image (although it is better to have a backup of the entire glamoroustoolkit directory tree).
2. Create a recovery branch ('recovery' by default).
3. Commit the image changes to the recovery branch.
4. Switch back to the main branch.
5. Merge changes from the recovery branch in.

If the merge fails, it is left to the user as homework to tidy things up.
"
Class {
	#name : #GtGitRecoverDetachedWithUncommittedChanges,
	#superclass : #GtGitRecovery,
	#instVars : [
		'recoveryBranchName',
		'recoveryBranch',
		'commitMessage'
	],
	#category : #'GToolkit-Utility-Git'
}

{ #category : #private }
GtGitRecoverDetachedWithUncommittedChanges >> commitImageChanges [

	self halt.
	self workingCopy
		commitChanges: self repository workingCopyDiff 
		withMessage: commitMessage
		force: false.
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> commitMessage [
	^ commitMessage
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> commitMessage: anObject [
	commitMessage := anObject
]

{ #category : #private }
GtGitRecoverDetachedWithUncommittedChanges >> createRecoveryBranch [
	recoveryBranch := self repository
			createBranch: recoveryBranchName
			inCommit: self imageCommit
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> ensureDeleteRecoveryBranch [
	"Just for testing, ensure the recovery branch doesn't exist"
	
	self repository
		branchNamed: recoveryBranchName
		ifPresent: [ :branch |
			self mainBranch checkout: (IceCheckoutDoNotLoadPackages new
				committish: self mainBranch commit;
				yourself).
			branch delete ].
]

{ #category : #initialization }
GtGitRecoverDetachedWithUncommittedChanges >> initialize [

	super initialize.
	recoveryBranchName := 'recovery'.
]

{ #category : #private }
GtGitRecoverDetachedWithUncommittedChanges >> mergeRecovery [
	"Merge the recovery branch in to the current branch (typically the main branch)"

	self recoveryBranch merge.
]

{ #category : #actions }
GtGitRecoverDetachedWithUncommittedChanges >> recover [
	self
		assert: recoveryBranchName isNotNil
		description: 'Recovery branch name must be set'.
	self
		assert: commitMessage isString
		description: 'Commit message must be set'.

	self repository
		branchNamed: self recoveryBranchName
		ifPresent: [ self error: 'Recovery branch already exists' ].

	self saveImage.
	self imageHash = self repositoryHash
		ifFalse: [ self workingCopy referenceCommit switch ].
	self createRecoveryBranch.
	self commitImageChanges.
	self checkoutMain.
	self mergeRecovery.
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> recoveryBranch [

	^ recoveryBranch
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> recoveryBranchName [
	^ recoveryBranchName
]

{ #category : #accessing }
GtGitRecoverDetachedWithUncommittedChanges >> recoveryBranchName: anObject [
	recoveryBranchName := anObject
]
