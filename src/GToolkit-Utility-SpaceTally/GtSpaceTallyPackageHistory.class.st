Class {
	#name : #GtSpaceTallyPackageHistory,
	#superclass : #GtSpaceTallyItemHistory,
	#instVars : [
		'analyzedPackageName'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyPackageHistory >> addTallyItemVersion: aTallyItemVersion [
	self assert: [ self analyzedPackageName = aTallyItemVersion analyzedPackageName ].
	 
	super addTallyItemVersion: aTallyItemVersion
]

{ #category : #accessing }
GtSpaceTallyPackageHistory >> analyzedPackageName [

	^ analyzedPackageName
]

{ #category : #accessing }
GtSpaceTallyPackageHistory >> analyzedPackageName: aPackageName [

	analyzedPackageName := aPackageName
]

{ #category : #printing }
GtSpaceTallyPackageHistory >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self analyzedPackageName;
		<< ')'
]
