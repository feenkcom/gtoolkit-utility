Class {
	#name : #GtSpaceTallyVersion,
	#superclass : #Object,
	#instVars : [
		'index',
		'label',
		'timestamp',
		'spaceTally',
		'vmMemorySize'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'gt - extensions' }
GtSpaceTallyVersion >> gtViewPackageTalliesFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies (by package)';
		priority: 15;
		object: [ spaceTally ];
		view: #gtViewPackageTalliesFor:
]

{ #category : #'gt - extensions' }
GtSpaceTallyVersion >> gtViewRepositoryTalliesFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies (by repository)';
		priority: 10;
		object: [ spaceTally ];
		view: #gtViewRepositoryTalliesFor:
]

{ #category : #'gt - extensions' }
GtSpaceTallyVersion >> gtViewTallyItemsFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ spaceTally ];
		view: #gtViewItemsFor:
]

{ #category : #'gt - extensions' }
GtSpaceTallyVersion >> gtViewTallyOverviewFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Overview';
		items:  [ self overviewData ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtSpaceTallyVersion >> index [

	^ index
]

{ #category : #accessing }
GtSpaceTallyVersion >> index: anInteger [

	index := anInteger
]

{ #category : #accessing }
GtSpaceTallyVersion >> label [
	^ label
]

{ #category : #accessing }
GtSpaceTallyVersion >> label: aLabel [
	label := aLabel.
	self spaceTally ifNotNil: [ :aSpaceTally |
		aSpaceTally label: aLabel ]
]

{ #category : #accessing }
GtSpaceTallyVersion >> overviewData [
	^ self spaceTally results gtOverviewData, { 
		'Vm Memory Size' -> self vmMemorySize humanReadableIsqByteSize }
]

{ #category : #recording }
GtSpaceTallyVersion >> recordSystemWideData [
	
	timestamp := DateAndTime now.
	
	self recordyVmMemorySize.
	self recordySystemWideSpaceTally .
]

{ #category : #recording }
GtSpaceTallyVersion >> recordySystemWideSpaceTally [
	Smalltalk garbageCollect.
	
	spaceTally := GtSpaceTally new.
	spaceTally systemWideSpaceTally.
]

{ #category : #recording }
GtSpaceTallyVersion >> recordyVmMemorySize [
	
	vmMemorySize := Smalltalk vm memorySize
]

{ #category : #accessing }
GtSpaceTallyVersion >> spaceTally [

	^ spaceTally
]

{ #category : #accessing }
GtSpaceTallyVersion >> spaceTally: aSpaceTally [

	spaceTally := aSpaceTally
]

{ #category : #accessing }
GtSpaceTallyVersion >> spaceTallyClassVersions [
	^ self spaceTally results items collect: [ :aTallyResult |
		GtSpaceTallyClassTallyVersion new
			tallyVersion: self;
			tallyItem: aTallyResult ]
]

{ #category : #accessing }
GtSpaceTallyVersion >> spaceTallyPackageVersions [
	^ self spaceTally packageTallies collect: [ :aPackageTally |
		GtSpaceTallyPackageTallyVersion new
			tallyVersion: self;
			tallyItem: aPackageTally ]
]

{ #category : #accessing }
GtSpaceTallyVersion >> spaceTallyRepositoryVersions [
	^ self spaceTally repositoryTallies collect: [ :aRepositoryTally |
		GtSpaceTallyRepositoryTallyVersion new
			tallyVersion: self;
			tallyItem: aRepositoryTally ]
]

{ #category : #accessing }
GtSpaceTallyVersion >> timestamp [

	^ timestamp
]

{ #category : #accessing }
GtSpaceTallyVersion >> timestamp: aDateAndTime [

	timestamp := aDateAndTime
]

{ #category : #accessing }
GtSpaceTallyVersion >> totalCodeSpace [
	^ self spaceTally results totalCodeSpace
]

{ #category : #accessing }
GtSpaceTallyVersion >> totalInstCount [
	^ self spaceTally results totalInstCount
]

{ #category : #accessing }
GtSpaceTallyVersion >> totalInstSpace [
	^ self spaceTally results totalInstSpace
]

{ #category : #accessing }
GtSpaceTallyVersion >> vmMemorySize [
	^ vmMemorySize
]
