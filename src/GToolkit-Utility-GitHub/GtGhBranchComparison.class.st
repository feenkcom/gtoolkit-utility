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
	(#(diverged behind ahead) includes: self status) ifTrue: [ 
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
	(#(diverged behind ahead) includes: self status) ifTrue: [ 
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
