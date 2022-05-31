Class {
	#name : #GtSpaceTallyPackageTally,
	#superclass : #Object,
	#instVars : [
		'analyzedPackageName',
		'classTallies'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyPackageTally >> addClassTallies: aCollection [
	aCollection do: [ :aTally |
		self addClassTally: aTally ]
]

{ #category : #adding }
GtSpaceTallyPackageTally >> addClassTally: aTally [
	self classTallies addItem: aTally
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> analyzedPackageName [

	^ analyzedPackageName
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> analyzedPackageName: anObject [

	analyzedPackageName := anObject
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> classTallies [
	^ classTallies
]

{ #category : #printing }
GtSpaceTallyPackageTally >> gtDescriptionOn: aStream [

	aStream print: analyzedPackageName .
	
	aStream nextPutAll: '('.
	aStream
		nextPutAll: ' instance count: ';
		print: self totalInstCount.
	aStream
		nextPutAll: ' space for instances: ';
		print: self totalInstSpace.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> gtViewTallyItemsFor: aView [
	<gtView>
	classTallies ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ classTallies ];
		view: #gtViewItemsFor:
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> gtViewTallyOverviewFor: aView [
	<gtView>
	classTallies ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Overview';
		object: [ classTallies ];
		view: #gtViewOverviewFor:
]

{ #category : #initialization }
GtSpaceTallyPackageTally >> initialize [
	super initialize.
	classTallies := SpaceTallyResult new.
]

{ #category : #printing }
GtSpaceTallyPackageTally >> printOn: aStream [
	super printOn: aStream.
	
	aStream << '('.
	self gtDescriptionOn: aStream.
	aStream << ')'.
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> totalInstCount [
	^ self classTallies totalInstCount
]

{ #category : #accessing }
GtSpaceTallyPackageTally >> totalInstSpace [
	^ self classTallies totalInstSpace
]
