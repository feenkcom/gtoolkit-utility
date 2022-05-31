Class {
	#name : #GtSpaceTallyHistory,
	#superclass : #Object,
	#instVars : [
		'tallyVersions',
		'tallyItemVersionsByClassName'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyHistory class >> default [
	^ defaultInstance ifNil: [ 
		defaultInstance := self new ]
]

{ #category : #accessing }
GtSpaceTallyHistory class >> recordDefaultSystemWideData [
	self default recordSystemWideData
]

{ #category : #initialization }
GtSpaceTallyHistory class >> reset [
	defaultInstance := nil
]

{ #category : #adding }
GtSpaceTallyHistory >> addSpaceTallyVersion: aSpaceTallyVersion [
	aSpaceTallyVersion index: self spaceTallyVersions size + 1.
	
	self spaceTallyVersions add: aSpaceTallyVersion.
	self updateClassHistoriesFor: aSpaceTallyVersion.
]

{ #category : #accessing }
GtSpaceTallyHistory >> classHistories [
	^ tallyItemVersionsByClassName values
]

{ #category : #accessing }
GtSpaceTallyHistory >> classHistoriesWithChanges [
	^ self classHistories select: [ :aClassHistory | 
		aClassHistory hasChanges ]
]

{ #category : #accessing }
GtSpaceTallyHistory >> firstVersion [
	^ self spaceTallyVersions first
]

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewAnalyzedClassesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Class Changes';
		items: [ 
			self classHistoriesWithChanges
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

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewAnalyzedPackagesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Package Changes';
		items: [ 
			self packageHistories
				sorted: [ :aPackageHistory | 
					aPackageHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Package Name' text: [ :aPackageHistory |
			aPackageHistory analyzedPackageName ];
		column: 'Count chance' text: [ :aPackageHistory |
			aPackageHistory instanceCountChange ];
		column: 'Size chance' text: [ :aPackageHistory |
			((aPackageHistory instanceSizeChange < 0)
				ifTrue: [
					'-', aPackageHistory instanceSizeChange 
						negated humanReadableIsqByteSize ]  
				ifFalse: [ 
					aPackageHistory instanceSizeChange humanReadableIsqByteSize ]) ];
		column: 'Latest Count' text: [ :aPackageHistory |
			aPackageHistory tallyItemVersions last totalInstCount ];
		column: 'Latest Size' text: [ :aPackageHistory |
			aPackageHistory tallyItemVersions last totalInstSpace humanReadableIsqByteSize ]
		
]

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewAnalyzedRepositoriesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Repository Changes';
		items: [ 
			self repositoryHistories
				sorted: [ :aRepositoryHistory | 
					aRepositoryHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Repository Name' text: [ :aRepositoryHistory |
			aRepositoryHistory analyzedRepositoryName ];
		column: 'Count chance' text: [ :aRepositoryHistory |
			aRepositoryHistory instanceCountChange ];
		column: 'Size chance' text: [ :aRepositoryHistory |
			((aRepositoryHistory instanceSizeChange < 0)
				ifTrue: [
					'-', aRepositoryHistory instanceSizeChange 
						negated humanReadableIsqByteSize ]  
				ifFalse: [ 
					aRepositoryHistory instanceSizeChange humanReadableIsqByteSize ]) ];
		column: 'Latest Count' text: [ :aRepositoryHistory |
			aRepositoryHistory tallyItemVersions last totalInstCount ];
		column: 'Latest Size' text: [ :aRepositoryHistory |
			aRepositoryHistory tallyItemVersions last totalInstSpace humanReadableIsqByteSize ]
		
]

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewVersionsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Tally Versions';
		items: [ self spaceTallyVersions ];
		column: 'Index' text: [ :aVersion |
			aVersion index ];
		column: 'Instance Count' text: [ :aVersion |
			aVersion totalInstCount ];
		column: 'Instances Size' text: [ :aVersion |
			aVersion totalInstSpace humanReadableIsqByteSize ];
		column: 'VM Memory Size' text: [ :aVersion |
			aVersion vmMemorySize humanReadableIsqByteSize ]
]

{ #category : #initialization }
GtSpaceTallyHistory >> initialize [ 
	super initialize.
	tallyVersions := OrderedCollection new.
	tallyItemVersionsByClassName := Dictionary new.
]

{ #category : #accessing }
GtSpaceTallyHistory >> latestVersion [
	^ self spaceTallyVersions last
]

{ #category : #accessing }
GtSpaceTallyHistory >> packageHistories [
	| tallyItemVersionsByPackageName |
	tallyItemVersionsByPackageName := OrderedDictionary new.
	self spaceTallyVersions do: [ :aSpaceTallyVersion |
		aSpaceTallyVersion spaceTallyPackageVersions do: [ :aPackageTallyVersion |
			| packageHistory |
			packageHistory := tallyItemVersionsByPackageName 
				at: aPackageTallyVersion analyzedPackageName 
				ifAbsentPut: [ GtSpaceTallyPackageHistory new
					analyzedPackageName: aPackageTallyVersion analyzedPackageName ].
			packageHistory addTallyItemVersion: aPackageTallyVersion ] ].
	^ tallyItemVersionsByPackageName values
]

{ #category : #accessing }
GtSpaceTallyHistory >> packageHistoriesWithChanges [
	^ self packageHistories select: [ :aPackageHistory | 
		aPackageHistory hasChanges ]
]

{ #category : #recording }
GtSpaceTallyHistory >> recordSystemWideData [
	| newVersion |
	
	newVersion := GtSpaceTallyVersion new.
	newVersion recordSystemWideData.
	
	self addSpaceTallyVersion: newVersion
]

{ #category : #accessing }
GtSpaceTallyHistory >> repositoryHistories [
	| tallyItemVersionsByRepositoryName |
	tallyItemVersionsByRepositoryName := OrderedDictionary new.
	self spaceTallyVersions do: [ :aSpaceTallyVersion |
		aSpaceTallyVersion spaceTallyRepositoryVersions do: [ :aRepositoryTallyVersion |
			| repositoryHistory |
			repositoryHistory := tallyItemVersionsByRepositoryName 
				at: aRepositoryTallyVersion analyzedRepositoryName 
				ifAbsentPut: [ GtSpaceTallyRepositoryHistory new
					analyzedRepositoryName: aRepositoryTallyVersion analyzedRepositoryName ].
			repositoryHistory addTallyItemVersion: aRepositoryTallyVersion ] ].
	^ tallyItemVersionsByRepositoryName values
]

{ #category : #accessing }
GtSpaceTallyHistory >> spaceTallyVersions [
	^ tallyVersions 
]

{ #category : #updating }
GtSpaceTallyHistory >> updateClassHistoriesFor: aSpaceTallyVersion [
	aSpaceTallyVersion spaceTallyClassVersions do: [ :aTallyItemVersion |
		| classHistory |
		classHistory := tallyItemVersionsByClassName 
			at: aTallyItemVersion analyzedClassName 
			ifAbsentPut: [ GtSpaceTallyClassHistory new
				analyzedClassName: aTallyItemVersion analyzedClassName ].
		classHistory addTallyItemVersion: aTallyItemVersion ]
]
