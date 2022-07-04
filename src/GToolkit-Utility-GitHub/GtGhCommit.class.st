"
{{gtClass:name=GtGhCommit}} models a commit from GitHub.
"
Class {
	#name : #GtGhCommit,
	#superclass : #GtGhEntity,
	#instVars : [
		'repositories'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhCommit >> authorName [
	^ self authorRawData at: 'name'
]

{ #category : #accessing }
GtGhCommit >> authorRawData [
	^ self commitRawData at: 'author'
]

{ #category : #accessing }
GtGhCommit >> commitRawData [
	^ self rawData at: 'commit'
]

{ #category : #accessing }
GtGhCommit >> message [
	^ self commitRawData at: 'message'
]

{ #category : #accessing }
GtGhCommit >> timestamp [
	^ DateAndTime fromString: (self authorRawData at: 'date')
]
