Class {
	#name : #GtSpaceTallyClassHistory,
	#superclass : #GtSpaceTallyItemHistory,
	#instVars : [
		'analyzedClassName'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyClassHistory >> addTallyItemVersion: aTallyItemVersion [
	self assert: [ self analyzedClassName = aTallyItemVersion analyzedClassName ].
	 
	super addTallyItemVersion: aTallyItemVersion
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> analyzedClassName [

	^ analyzedClassName
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> analyzedClassName: aSymbol [

	analyzedClassName := aSymbol
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self analyzedClassName;
		<< ')'
]
