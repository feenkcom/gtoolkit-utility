Class {
	#name : #GtGitPullAndLoadImageCommit,
	#superclass : #GtGitPullAndLoad,
	#instVars : [
		'onDetachedBranchName'
	],
	#category : #'GToolkit-Utility-Git'
}

{ #category : #private }
GtGitPullAndLoadImageCommit >> confirmImageHashKnown [

	IceRepository registry
		detect: [ :repo | repo location = self repositoryDirectory ]
		ifFound: [ :repo | repo origin url = self repositoryUrl
			ifTrue: [ ^ self ]
			ifFalse: [ self error: 'Repository origin and location mismatch' ] ]
		ifNone: [ self error: 'Unable to determine image hash' ]
]

{ #category : #accessing }
GtGitPullAndLoadImageCommit >> onDetachedBranchName [
	^ onDetachedBranchName
]

{ #category : #accessing }
GtGitPullAndLoadImageCommit >> onDetachedBranchName: anObject [
	onDetachedBranchName := anObject
]

{ #category : #actions }
GtGitPullAndLoadImageCommit >> recover [
	"Move to the image commit"
	| imageHash repositoryHash |

	self confirmImageHashKnown.

	"Retrieving the repository has the side-effect of creating it if required"
	imageHash := self imageHash.
	self repository.
	"Don't worry about merge warnings, we'll be switching to a known state."
	[ self mainBranch pull ]
		on: IceExperimentalFeature
		do: [ :ex | ex resume ].
	repositoryHash := self repositoryHash.

	imageHash = repositoryHash ifFalse: 
		[ self workingCopy referenceCommit switch ].

	(self repository head isDetached and: [ onDetachedBranchName isString ]) ifTrue:
		[ self repository createBranch: onDetachedBranchName ]
]
