Class {
	#name : #GtSpaceTallyRepositoryTally,
	#superclass : #Object,
	#instVars : [
		'analyzedRepositoryName',
		'packageTallies'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyRepositoryTally >> addPackageTallies: aCollection [
	aCollection do: [ :aTally |
		self addPackageTally: aTally ]
]

{ #category : #adding }
GtSpaceTallyRepositoryTally >> addPackageTally: aTally [
	self packageTallies add: aTally
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> analyzedRepositoryName [

	^ analyzedRepositoryName
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> analyzedRepositoryName: anObject [

	analyzedRepositoryName := anObject
]

{ #category : #printing }
GtSpaceTallyRepositoryTally >> descriptionOn: aStream [

	aStream print: analyzedRepositoryName.
	
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
GtSpaceTallyRepositoryTally >> gtOverviewData [
	^ { 
		'Instance count' -> self totalInstCount.
		'Instances Size' -> self totalInstSpace humanReadableIsqByteSize }
]

{ #category : #'gt - extensions' }
GtSpaceTallyRepositoryTally >> gtViewTallyItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Items';
		items:  [ self packageTallies sorted: [ :aSpaceTallyItem | 
			aSpaceTallyItem spaceForInstances ] descending ];
		column: 'Package' text: [ :aSpaceTallyItem | aSpaceTallyItem analyzedPackageName ];
		column: 'Instance count' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem instanceCount ];
		column: 'Instances Size' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem spaceForInstances humanReadableIsqByteSize ]
]

{ #category : #'gt - extensions' }
GtSpaceTallyRepositoryTally >> gtViewTallyOverviewFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Overview';
		items:  [ self gtOverviewData ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #initialization }
GtSpaceTallyRepositoryTally >> initialize [
	super initialize.
	packageTallies := OrderedCollection new.
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> instanceCount [ 
	^ self totalInstCount
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> packageTallies [
	^ packageTallies
]

{ #category : #printing }
GtSpaceTallyRepositoryTally >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> spaceForInstances [ 
	^ self totalInstSpace 
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> totalInstCount [
	^ self packageTallies sum: #totalInstCount
]

{ #category : #accessing }
GtSpaceTallyRepositoryTally >> totalInstSpace [
	^ self packageTallies sum: #totalInstSpace
]
