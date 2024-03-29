"
{{gtClass:name=GtGhRepository}} models a GitHub repository.

It provides varios information about the repository like:
	- {{gtMethod:name=GtGhRepository>>forkedRepository|label=#selector}}:  the repository from which this repository was forked, in case the repository is a fork;
	-  {{gtMethod:name=GtGhRepository>>defaultBranch|label=#selector}}
	
It makes requests as needed to the GitHub API to download information.
"
Class {
	#name : #GtGhRepository,
	#superclass : #GtGhEntity,
	#instVars : [
		'hasFullRawData',
		'forkedRepository',
		'branchesByName',
		'diffWithRemote'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepository >> branchUrlFor: aBranchName [
	^ (self rawData at: 'branches_url') 
		copyReplaceAll: '{/branch}'
		with: '/', aBranchName
]

{ #category : #'accessing properties' }
GtGhRepository >> compareUrl [
	^ self rawData at: 'compare_url'
]

{ #category : #accessing }
GtGhRepository >> compareUrlOfBase: aBaseSpec withHead: aHeadSpec [
	^ (self compareUrl
		copyReplaceAll: '{base}' with: aBaseSpec)
		copyReplaceAll: '{head}' with: aHeadSpec
]

{ #category : #'accessing properties' }
GtGhRepository >> createdAt [
	^ DateAndTime fromString: (self rawData at: 'created_at')
]

{ #category : #accessing }
GtGhRepository >> defaultBranch [ 
	^ branchesByName 
		at: self defaultBranchName 
		ifAbsentPut: [ self loadBranchNamed: self defaultBranchName ]
]

{ #category : #'accessing properties' }
GtGhRepository >> defaultBranchName [
	^ self rawData at: 'default_branch'
]

{ #category : #'accessing properties' }
GtGhRepository >> description [
	^ self rawData at: 'description'
]

{ #category : #'loading - utils' }
GtGhRepository >> diffWithParentForLocalBranchNamed:  aLoadedBranchName [
	self assert: [ self isForked ].
	
	^ diffWithRemote ifNil:  [ 
		diffWithRemote := self loadDiffWithParentForLoadedBranchNamed: aLoadedBranchName ]
]

{ #category : #accessing }
GtGhRepository >> enureFullRawData [
	hasFullRawData ifFalse: [ 
		self fullRawData: self loadFullInformation ]
]

{ #category : #accessing }
GtGhRepository >> forkedRepository [
	self isForked ifFalse: [ ^ nil ].
	
	^ forkedRepository ifNil: [
		forkedRepository := self loadForkedRepository ]
]

{ #category : #'accessing properties' }
GtGhRepository >> fullName [ 
	^ self rawData at: 'full_name'
]

{ #category : #accessing }
GtGhRepository >> fullRawData: aRawData [
	self rawData: aRawData.
	hasFullRawData := true 
]

{ #category : #initialization }
GtGhRepository >> initialize [
	super initialize.
	hasFullRawData := false.
	branchesByName := OrderedDictionary new.
]

{ #category : #testing }
GtGhRepository >> isForked [ 
	^ self rawData at: 'fork'
]

{ #category : #'loading - utils' }
GtGhRepository >> loadBranchNamed: aBranchName [
	| branchRawData |
	
	branchRawData := self githubGet: (self branchUrlFor: aBranchName).
	^ GtGhRepositoryBranch new
		rawData: branchRawData
]

{ #category : #'loading - utils' }
GtGhRepository >> loadDiffWithParentForLoadedBranchNamed: aLoadedBranchName [
	| headSpec rawDiffData |
	self isForked ifFalse: [ ^ self ].
	
	headSpec := self forkedRepository ownerLoginName, ':', 
		self forkedRepository defaultBranchName.
	rawDiffData := self githubGet: (self 
		compareUrlOfBase: aLoadedBranchName 
		withHead: headSpec).
			
	^ GtGhBranchComparison new
		baseSpec: aLoadedBranchName;
		headSpec: headSpec;
		rawData: rawDiffData
]

{ #category : #'loading - utils' }
GtGhRepository >> loadForkedRepository [
	self enureFullRawData.
	^ self class new 
		rawData: (self rawData at: 'parent')
]

{ #category : #'loading - utils' }
GtGhRepository >> loadFullInformation [
	^ self githubGet: self url 
]

{ #category : #'accessing properties' }
GtGhRepository >> name [ 
	^ self rawData at: 'name'
]

{ #category : #'accessing properties' }
GtGhRepository >> ownerData [
	^ self rawData at: 'owner'
]

{ #category : #'accessing properties' }
GtGhRepository >> ownerLoginName [
	^ self ownerData at: 'login'
]

{ #category : #printing }
GtGhRepository >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream << self fullName ]
]

{ #category : #'accessing properties' }
GtGhRepository >> pushedAt [
	^ DateAndTime fromString: (self rawData at: 'pushed_at')
]

{ #category : #'accessing properties' }
GtGhRepository >> url [
	^ self rawData at: 'url'
]
