"
{{gtClass:GtGhRepositoryWithBaseline}}  augments a baseline repository with data about that repository from GitHub.

The baseline repository is an instance of  {{gtClass:name=GtRlRepository}} and models a repository in a Metacello baseline.
The GitHub repository is an instance of {{gtClass:name=GtGhRepository}} and contains data from GitHub.

By linking the two it can extract information from GitHub based on the load specification of a repository in a Metacello baseline, especially the branch that is specified by the baseline.

Several usefull API methods:
	- {{gtMethod:name=GtGhRepositoryWithBaseline>>#loadedBranchName|label=#selector}}
	- {{gtMethod:name=GtGhRepositoryWithBaseline>>#branchDiffFromSelfToParent|label=#selector}}



"
Class {
	#name : #GtGhRepositoryWithBaseline,
	#superclass : #Object,
	#instVars : [
		'gitHubRepository',
		'baselineRepository'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepositoryWithBaseline >> baselineRepository [

	^ baselineRepository
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> baselineRepository: anObject [

	baselineRepository := anObject
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> branchDiffFromSelfToParent [
	"Create a diff between the branch loaded by Metacello from this repository and the default branch of its parent repository. The current repository should be a fork. This uses the current repository as the source when doing the diff." 
	
	self assert: [ self gitHubRepository isForked ].
	
	^ self gitHubRepository 
		diffWithParentForLocalBranchNamed: self loadedBranchName
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> defautBranchNameInParent [
	^ self gitHubRepository forkedRepository defaultBranchName
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gitHubDescription [
	^ self gitHubRepository description
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gitHubRepository [

	^ gitHubRepository
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gitHubRepository: anObject [

	gitHubRepository := anObject
]

{ #category : #'gt - extensions' }
GtGhRepositoryWithBaseline >> gtViewCommitsBehindParentFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Behind Commits';
		items: [ self branchDiffFromSelfToParent commits ];
		column: 'Timestamp' text: [ :aCommit | aCommit timestamp ] width: 200;
		column: 'Author' text: [ :aCommit | aCommit authorName ] width: 200;
		column: 'Messsage' text: [ :aCommit | aCommit message ]
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> loadSpecString [
	^ self baselineRepository loadSpecificationString
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> loadedBranchName [
	"The name of the branch that is going to be loded based on the load specification from the baseline. If bo branch name is specified, 'master' is going to be used."
	
	^ self baselineRepository versionStringOrNil
		ifNil: [ 'master' ]
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> ownerName [
	^ baselineRepository ownerName
]

{ #category : #printing }
GtGhRepositoryWithBaseline >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: self  baselineRepository loadSpecificationString;
		nextPutAll: ')'
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> repositoryName [
	^ baselineRepository repositoryName
]
