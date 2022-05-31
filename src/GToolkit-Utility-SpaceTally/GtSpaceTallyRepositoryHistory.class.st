Class {
	#name : #GtSpaceTallyRepositoryHistory,
	#superclass : #GtSpaceTallyItemHistory,
	#instVars : [
		'analyzedRepositoryName'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyRepositoryHistory >> analyzedRepositoryName [

	^ analyzedRepositoryName
]

{ #category : #accessing }
GtSpaceTallyRepositoryHistory >> analyzedRepositoryName: aRepositoryName [

	analyzedRepositoryName := aRepositoryName
]

{ #category : #printing }
GtSpaceTallyRepositoryHistory >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self analyzedRepositoryName;
		<< ')'
]
