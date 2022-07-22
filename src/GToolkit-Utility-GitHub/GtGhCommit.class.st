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
GtGhCommit >> commitId [
	^ self rawData at: 'sha'
]

{ #category : #accessing }
GtGhCommit >> commitRawData [
	^ self rawData at: 'commit'
]

{ #category : #accessing }
GtGhCommit >> gtViewCommitMessageFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Commit Message';
		text: [ self message ]
]

{ #category : #accessing }
GtGhCommit >> gtViewDetailsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Details';
		items: [ {
			'Commit'  -> ('[' , self shortId , '] ' , self commitId).
			'Parents' -> self parentIds asCommaString.
			'Author'  -> self authorName.
			'Date'    -> self timestamp asStringYMDHM.
			'Comment' -> self message} ];
		column: 'Property' text: #key width: 150;
		column: 'Value' text: #value;
		send: #value
	
]

{ #category : #accessing }
GtGhCommit >> message [
	^ self commitRawData at: 'message'
]

{ #category : #accessing }
GtGhCommit >> parentIds [
	^ self rawData
		at: 'parents' 
		ifPresent: [ :parentsData | 
			parentsData collect: [ :aParentCommitData |
				aParentCommitData at: 'sha' ]] 
		ifAbsent: [ #() ]
]

{ #category : #accessing }
GtGhCommit >> shortId [
	
	"This is just for presentation purposes.
	Don't trust this id, it is not guaranteed to be unique"
	^ self commitId first: 7
]

{ #category : #accessing }
GtGhCommit >> timestamp [
	^ DateAndTime fromString: (self authorRawData at: 'date')
]
