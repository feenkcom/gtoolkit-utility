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
GtGhRepositoryWithBaseline >> branchDiffWithFork [
	^ self gitHubRepository 
		forkDiffWithLocalBranchNamed: self loadedBranchName
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> forkDefautBranchName [
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

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gtViewBehindCommitsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Behind Commits';
		items: [ self branchDiffWithFork commits ];
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

{ #category : #accessing }
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
