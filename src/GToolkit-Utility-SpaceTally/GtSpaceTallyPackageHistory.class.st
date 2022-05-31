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

{ #category : #accessing }
GtSpaceTallyPackageHistory >> classHistories [
	| tallyItemVersionsByClassName |
	tallyItemVersionsByClassName := OrderedDictionary new.
	self tallyItemVersions do: [ :aPackageVersion |
		aPackageVersion spaceTallyClassVersions do: [ :aClassTallyVersion |
			| classHistory |
			classHistory := tallyItemVersionsByClassName 
				at: aClassTallyVersion analyzedClassName 
				ifAbsentPut: [ GtSpaceTallyClassHistory new
					analyzedClassName: aClassTallyVersion analyzedClassName ].
			classHistory addTallyItemVersion: aClassTallyVersion ] ].
	^ tallyItemVersionsByClassName values
]

{ #category : #'gt - extensions' }
GtSpaceTallyPackageHistory >> gtViewAnalyzedClassesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Class Changes';
		items: [ 
			self classHistories
				sorted: [ :aClassHistory | 
					aClassHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Class Name' text: [ :aClassHistory |
			aClassHistory analyzedClassName ];
		column: 'Count chance' text: [ :aClassHistory |
			aClassHistory instanceCountChange ];
		column: 'Size chance' text: [ :aClassHistory |
			((aClassHistory instanceSizeChange < 0)
				ifTrue: [
					'-', aClassHistory instanceSizeChange negated humanReadableIsqByteSize ]  
				ifFalse: [ 
					aClassHistory instanceSizeChange humanReadableIsqByteSize ]) ];
		column: 'Latest Count' text: [ :aClassHistory |
			aClassHistory tallyItemVersions last totalInstCount ];
		column: 'Latest Size' text: [ :aClassHistory |
			aClassHistory tallyItemVersions last totalInstSpace humanReadableIsqByteSize ]
]

{ #category : #printing }
GtSpaceTallyPackageHistory >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self analyzedPackageName;
		<< ')'
]
