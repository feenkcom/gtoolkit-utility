"
{{gtClass:name=GtGhRepositoryBranch}} models a repository branch on GitHub.
"
Class {
	#name : #GtGhRepositoryBranch,
	#superclass : #GtGhEntity,
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepositoryBranch >> commitData [
	^ self rawData at: 'commit'
]

{ #category : #accessing }
GtGhRepositoryBranch >> latestCommitTimestamp [
	^ DateAndTime fromString: (((self commitData 
		at: 'commit') 
		at: 'author') 
		at: 'date')
]
