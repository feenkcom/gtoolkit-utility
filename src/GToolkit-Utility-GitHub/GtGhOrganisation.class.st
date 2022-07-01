Class {
	#name : #GtGhOrganisation,
	#superclass : #GtGhEntity,
	#instVars : [
		'repositories'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #'instance creation' }
GtGhOrganisation class >> forLogin: aLoginName [ 
	
	^ self new 
		initializeForLogin: aLoginName
]

{ #category : #querying }
GtGhOrganisation >> forkedRepositories [ 
	^ self repositories select: [ :aRepository | aRepository isForked ]
]

{ #category : #'gt - extensions' }
GtGhOrganisation >> gtViewRepositoriesFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Repositories';
		items: [ self repositories 
			sorted: [ :aRepository | aRepository name ] ascending ];
		column: 'Name' text: [ :aRepository | aRepository name ];
		column: 'Description' text: [ :aRepository | aRepository description ]
]

{ #category : #initialization }
GtGhOrganisation >> initializeForLogin: aLoginName [
	
	self rawData: (self githubGet: ('orgs/', aLoginName))
]

{ #category : #loading }
GtGhOrganisation >> loadRepositories [
	^ self loadRepositoriesData 
		collect: [ :aRawData |
			GtGhRepository new 
				rawData: aRawData ]
]

{ #category : #loading }
GtGhOrganisation >> loadRepositoriesData [ 
	| loadedRepositories reposChunk pageCount |
	
	loadedRepositories := OrderedCollection new.
	pageCount := 1.
	reposChunk := nil.
	
	[ 
		reposChunk := self githubGet: self repositoriesUrl
			, '?per_page=100&page=', pageCount asString.
		pageCount := pageCount +1. 
		loadedRepositories addAll: reposChunk.
	] doWhileTrue: [
		reposChunk size = 100 ].
	
	^ loadedRepositories
]

{ #category : #accessing }
GtGhOrganisation >> loginName [
	^ self rawData at: 'login'
]

{ #category : #querying }
GtGhOrganisation >> ownedRepositories [ 
	^ self repositories reject: [ :aRepository | aRepository isForked ]
]

{ #category : #printing }
GtGhOrganisation >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream << self loginName ]
]

{ #category : #accessing }
GtGhOrganisation >> repositories [
	^ repositories ifNil: [ 
		repositories := self loadRepositories ]
]

{ #category : #accessing }
GtGhOrganisation >> repositoriesUrl [
	^ self rawData at: 'repos_url'
]

{ #category : #querying }
GtGhOrganisation >> repositoryNamed: aRepositoryName [
	^ self repositories detect: [ :aRepository | 
			aRepository name = aRepositoryName ]
]
