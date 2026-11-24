"
{{gtClass:GtGhBranchComparison}} performs a comparison between two branches using the compare url.

The compare url has  the form `/repos/{owner}/{repo}/compare/{base}...{head}`.
"
Class {
	#name : #GtGhBranchComparison,
	#superclass : #GtGhEntity,
	#instVars : [
		'baseSpec',
		'headSpec',
		'commits'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #examples }
GtGhBranchComparison class >> exampleAheadComparison [
	"A head branch with commits the base branch does not have"
	<gtExample>
	<return: #GtGhBranchComparison>
	| comparison |
	comparison := self new
		baseSpec: 'main';
		headSpec: 'example-owner:main';
		rawData: (STON fromString: '{"status":"ahead","ahead_by":1,"behind_by":0,"total_commits":1,"commits":[]}');
		yourself.
	self assert: comparison reverseStatus equals: 'behind'.
	self assert: comparison description equals: 'The branch main is 1 commits ahead with example-owner:main'.
	self assert: comparison reverseDescription equals: 'The branch main is 1 commits behind with example-owner:main'.
	^ comparison
]

{ #category : #examples }
GtGhBranchComparison class >> exampleDivergedComparison [
	"A comparison as the GitHub compare API answers it, read the way IceGitHubAPI>>#get: reads it (STON: String keys and values)"
	<gtExample>
	<return: #GtGhBranchComparison>
	| comparison |
	comparison := self new
		baseSpec: 'main';
		headSpec: 'example-owner:main';
		rawData: (STON fromString: '{"status":"diverged","ahead_by":2,"behind_by":3,"total_commits":2,"commits":[]}');
		yourself.
	self assert: comparison status equals: 'diverged'.
	self assert: comparison reverseStatus equals: 'diverged'.
	self
		assert: comparison description
		equals: 'The branch main is 2 commits ahead, 3 commits behind with example-owner:main'.
	self
		assert: comparison reverseDescription
		equals: 'The branch main is 3 commits ahead, 2 commits behind with example-owner:main'.
	^ comparison
]

{ #category : #examples }
GtGhBranchComparison class >> exampleIdenticalComparison [
	"Two branches with the same commits"
	<gtExample>
	<return: #GtGhBranchComparison>
	| comparison |
	comparison := self new
		baseSpec: 'main';
		headSpec: 'example-owner:main';
		rawData: (STON fromString: '{"status":"identical","ahead_by":0,"behind_by":0,"total_commits":0,"commits":[]}');
		yourself.
	self assert: comparison reverseStatus equals: 'identical'.
	self assert: comparison description equals: 'The branch main is up to date with example-owner:main'.
	self assert: comparison reverseDescription equals: 'The branch main is up to date with example-owner:main'.
	^ comparison
]

{ #category : #printing }
GtGhBranchComparison >> aheadBy [
	^ self rawData at: 'ahead_by'
]

{ #category : #accessing }
GtGhBranchComparison >> baseSpec [

	^ baseSpec
]

{ #category : #accessing }
GtGhBranchComparison >> baseSpec: anObject [

	baseSpec := anObject
]

{ #category : #printing }
GtGhBranchComparison >> behindBy [
	^ self rawData at: 'behind_by'
]

{ #category : #accessing }
GtGhBranchComparison >> commits [
	^ (self rawData at: 'commits')
		collect: [ :aCommitData |
			GtGhCommit new 
				rawData: aCommitData ]
]

{ #category : #printing }
GtGhBranchComparison >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
GtGhBranchComparison >> descriptionOn: aStream [
	aStream 
		<< 'The branch ';
		<< self baseSpec;
		<< ' is '.
	self diffStatusOn: aStream.
	aStream
		<< ' with ';
		<< self headSpec.
]

{ #category : #printing }
GtGhBranchComparison >> diffStatusOn: aStream [ 
	(#('diverged' 'behind' 'ahead') includes: self status) ifTrue: [ 
		| parts |
		parts := OrderedCollection new.
		
		self aheadBy > 0 ifTrue: [ 
			parts add: self aheadBy asString, ' commits ahead' ].
		self behindBy > 0 ifTrue: [ 
			parts add: self behindBy asString, ' commits behind' ].
		aStream << parts asCommaString.
		^ self ].
		
	aStream << 'up to date'
]

{ #category : #accessing }
GtGhBranchComparison >> headSpec [

	^ headSpec
]

{ #category : #accessing }
GtGhBranchComparison >> headSpec: anObject [

	headSpec := anObject
]

{ #category : #accessing }
GtGhBranchComparison >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream 
			<< self baseSpec;
			<< '...';
			<< self headSpec ]
]

{ #category : #printing }
GtGhBranchComparison >> reverseDescription [
	^ String streamContents: [ :aStream |
		self reverseDescriptionOn: aStream ]
]

{ #category : #printing }
GtGhBranchComparison >> reverseDescriptionOn: aStream [
	aStream 
		<< 'The branch ';
		<< self baseSpec;
		<< ' is '.
	self reverseDiffStatusOn: aStream.
	aStream
		<< ' with ';
		<< self headSpec.
]

{ #category : #printing }
GtGhBranchComparison >> reverseDiffStatusOn: aStream [ 
	(#('diverged' 'behind' 'ahead') includes: self status) ifTrue: [ 
		| parts |
		parts := OrderedCollection new.
		
		self behindBy > 0 ifTrue: [ 
			parts add: self behindBy asString, ' commits ahead' ].
		self aheadBy > 0 ifTrue: [ 
			parts add: self aheadBy asString, ' commits behind' ].
		aStream << parts asCommaString.
		^ self ].
		
	aStream << 'up to date'
]

{ #category : #printing }
GtGhBranchComparison >> reverseStatus [
	self status = 'behind' ifTrue: [ ^ 'ahead' ].
	self status = 'ahead' ifTrue: [ ^ 'behind' ].
	^ self status
]

{ #category : #printing }
GtGhBranchComparison >> status [
	^ self rawData at: 'status'
]

{ #category : #accessing }
GtGhBranchComparison >> statusStringOn: aStream [
]
