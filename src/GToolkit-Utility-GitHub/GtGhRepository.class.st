Class {
	#name : #GtGhRepository,
	#superclass : #GtGhEntity,
	#instVars : [
		'hasFullRawData',
		'forkedRepository'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepository >> createdAt [
	^ DateAndTime fromString: (self rawData at: 'created_at')
]

{ #category : #accessing }
GtGhRepository >> defaultBranchName [
	^ self rawData at: 'default_branch'
]

{ #category : #accessing }
GtGhRepository >> description [
	^ self rawData at: 'description'
]

{ #category : #accessing }
GtGhRepository >> enureFullRawData [
	hasFullRawData ifFalse: [ 
		rawData := self loadFullInformation.
		hasFullRawData := true ]
]

{ #category : #accessing }
GtGhRepository >> forkedRepository [
	self isForked ifFalse: [ ^ nil ].
	^ forkedRepository ifNil: [
		forkedRepository := self loadForkedRepository ]
]

{ #category : #accessing }
GtGhRepository >> fullName [ 
	^ self rawData at: 'full_name'
]

{ #category : #accessing }
GtGhRepository >> hasNewerPushInOrigin [
	self isForked ifFalse: [ ^ false ].
	
	^ self forkedRepository pushedAt > self pushedAt
]

{ #category : #accessing }
GtGhRepository >> initialize [
	super initialize.
	hasFullRawData := false.
]

{ #category : #accessing }
GtGhRepository >> isForked [ 
	^ self rawData at: 'fork'
]

{ #category : #accessing }
GtGhRepository >> loadBranches [
	^ self githubClient
		get: 'repos/feenkcom/Bloc/branches'
]

{ #category : #accessing }
GtGhRepository >> loadForkedRepository [
	self enureFullRawData.
	^ self class new 
		rawData: (self rawData at: 'parent')
]

{ #category : #accessing }
GtGhRepository >> loadFullInformation [
	^ self githubClient
		get: (self url removePrefix: 'https://api.github.com/')
]

{ #category : #accessing }
GtGhRepository >> name [ 
	^ self rawData at: 'name'
]

{ #category : #printing }
GtGhRepository >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream << self fullName ]
]

{ #category : #accessing }
GtGhRepository >> pushedAt [
	^ DateAndTime fromString: (self rawData at: 'pushed_at')
]

{ #category : #accessing }
GtGhRepository >> url [
	^ self rawData at: 'url'
]
