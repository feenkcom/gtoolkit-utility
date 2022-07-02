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
	^ self gitHubRepository 
		diffBetweenParentAndLocalBranchNamed: self loadedBranchName
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
	^ self baselineRepository versionStringOrNil
		ifNil: [ self gitHubRepository defaultBranchName ]
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
