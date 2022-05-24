Class {
	#name : #GtSpaceTallyClassHistory,
	#superclass : #Object,
	#instVars : [
		'analyzedClassName',
		'tallyItemVersions'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyClassHistory >> addTallyItemVersion: aTallyItemVersion [
	self assert: [ self analyzedClassName = aTallyItemVersion analyzedClassName ].
	 
	self tallyItemVersions add: aTallyItemVersion 
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
GtSpaceTallyClassHistory >> firstVersion [
	^ self tallyItemVersions first
]

{ #category : #'gt - extensions' }
GtSpaceTallyClassHistory >> gtViewTallVersionsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Versions';
		items: [ self tallyItemVersions ];
		column: 'Version' text: [ :aClassHistory | aClassHistory tallyVersion index ];
		column: 'Instance Count' text: [ :aClassHistory |
			aClassHistory tallyItem instanceCount ];
		column: 'Instances Size' text: [ :aClassHistory |
			aClassHistory tallyItem spaceForInstances humanReadableIsqByteSize ]
]

{ #category : #testing }
GtSpaceTallyClassHistory >> hasChanges [
	^ self hasInstanceCountChange or: [
		self hasSizeChange ]
]

{ #category : #testing }
GtSpaceTallyClassHistory >> hasInstanceCountChange [
	^ (self tallyItemVersions collectAsSet: [ :aTallyVersion |
		aTallyVersion instanceCount ]) size > 1
]

{ #category : #testing }
GtSpaceTallyClassHistory >> hasSizeChange [
	^ (self tallyItemVersions collectAsSet: [ :aTallyVersion |
		aTallyVersion spaceForInstances ]) size > 1
]

{ #category : #initialization }
GtSpaceTallyClassHistory >> initialize [ 
	super initialize.
	tallyItemVersions := OrderedCollection new.
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> instanceCountChange [
	^ self latestVersion instanceCount - self firstVersion instanceCount
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> instanceSizeChange [
	^ self latestVersion spaceForInstances - self firstVersion spaceForInstances
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> latestVersion [
	^ self tallyItemVersions last
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> printOn: aStream [
	super printOn: aStream.
	aStream 
		<< '(';
		<< self analyzedClassName;
		<< ')'
]

{ #category : #accessing }
GtSpaceTallyClassHistory >> tallyItemVersions [
	^ tallyItemVersions
]
