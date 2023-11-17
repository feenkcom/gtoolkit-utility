"
GtGitRecoverDetachedHead attempts to recover from the situation where a repository is in 'Detached HEAD' state and there are no changes to the respository in the image, or that any changes may be discarded.
"
Class {
	#name : #GtGitRecoverDetachedHead,
	#superclass : #GtGitRecovery,
	#category : #'GToolkit-Utility-Git'
}

{ #category : #actions }
GtGitRecoverDetachedHead >> recover [

	self mainBranch checkout.
]
