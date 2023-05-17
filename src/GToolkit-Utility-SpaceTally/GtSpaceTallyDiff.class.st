Class {
	#name : #GtSpaceTallyDiff,
	#superclass : #Object,
	#instVars : [
		'sourceVersion',
		'targetVersion'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyDiff >> classHistories [
	| tallyItemVersionsByClassName |
	tallyItemVersionsByClassName := OrderedDictionary new.
	{self sourceVersion. self targetVersion} do: [ :aSpaceTallyVersion |
		aSpaceTallyVersion spaceTallyClassVersions do: [ :aClassTallyVersion |
			| classHistory |
			classHistory := tallyItemVersionsByClassName 
				at: aClassTallyVersion analyzedClassName 
				ifAbsentPut: [ GtSpaceTallyClassHistory new
					analyzedClassName: aClassTallyVersion analyzedClassName ].
			classHistory addTallyItemVersion: aClassTallyVersion ] ].
	^ tallyItemVersionsByClassName values
]

{ #category : #'gt - extensions' }
GtSpaceTallyDiff >> gtViewAnalyzedClassesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Class changes';
		priority: 20;
		items: [ 
			self classHistories
				sorted: [ :aClassHistory | 
					aClassHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Class Name' text: [ :aClassHistory |
			aClassHistory analyzedClassName ];
		column: 'Count change' text: [ :aClassHistory |
			aClassHistory instanceCountChange ];
		column: 'Size change' text: [ :aClassHistory |
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
GtSpaceTallyDiff >> gtViewAnalyzedPackagesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Package changes';
		priority: 15;
		items: [ 
			self packageHistories
				sorted: [ :aPackageHistory | 
					aPackageHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Package Name' text: [ :aPackageHistory |
			aPackageHistory analyzedPackageName ];
		column: 'Count change' text: [ :aPackageHistory |
			aPackageHistory instanceCountChange ];
		column: 'Size change' text: [ :aPackageHistory |
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
GtSpaceTallyDiff >> gtViewAnalyzedRepositoriesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Repository changes';
		items: [ 
			self repositoryHistories
				sorted: [ :aRepositoryHistory | 
					aRepositoryHistory tallyItemVersions last totalInstSpace ] descending ];
		column: 'Repository Name' text: [ :aRepositoryHistory |
			aRepositoryHistory analyzedRepositoryName ];
		column: 'Count change' text: [ :aRepositoryHistory |
			aRepositoryHistory instanceCountChange ];
		column: 'Size change' text: [ :aRepositoryHistory |
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
GtSpaceTallyDiff >> gtViewGCTextualDiffFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'GC';
		priority: 50;
		object: [ self vmStatisticsDiffReport ];
		view: #gtViewTextualDiffFor: 
]

{ #category : #'gt - extensions' }
GtSpaceTallyDiff >> gtViewVersionsDiffFor: aView [
	"<gtView>"
	
	^ aView columnedList 
		title: 'Versions Overview';
		items: [ { 
			'Instance count' -> [].
			'Instances Size' -> [] } ];
		column: 'Property' text: [ :assoc |
			assoc key ];
		column: 'Source Version' text: [ :assoc |
			assoc value first ];
		column: 'Target Version' text: [ :assoc |
			assoc value second ]
]

{ #category : #'gt - extensions' }
GtSpaceTallyDiff >> gtViewVersionsOverviewFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Versions overview';
		priority: 10;
		items: [ self versionsOverviewData ];
		column: 'Property' text: [ :assoc |
			assoc key ];
		column: 'Source Version: ', self sourceVersion description 
			text: [ :assoc |
				assoc value first ];
		column: 'Target Version: ', self targetVersion description 
			text: [ :assoc |
				assoc value second ]
]

{ #category : #accessing }
GtSpaceTallyDiff >> packageHistories [
	| tallyItemVersionsByPackageName |
	tallyItemVersionsByPackageName := OrderedDictionary new.
	{self sourceVersion. self targetVersion} do: [ :aSpaceTallyVersion |
		aSpaceTallyVersion spaceTallyPackageVersions do: [ :aPackageTallyVersion |
			| packageHistory |
			packageHistory := tallyItemVersionsByPackageName 
				at: aPackageTallyVersion analyzedPackageName 
				ifAbsentPut: [ GtSpaceTallyPackageHistory new
					analyzedPackageName: aPackageTallyVersion analyzedPackageName ].
			packageHistory addTallyItemVersion: aPackageTallyVersion ] ].
	^ tallyItemVersionsByPackageName values
]

{ #category : #printing }
GtSpaceTallyDiff >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		self sourceVersion descriptionOn: aStream.
		aStream << ' - '.
		self targetVersion descriptionOn: aStream ]
]

{ #category : #accessing }
GtSpaceTallyDiff >> repositoryHistories [
	| tallyItemVersionsByRepositoryName |
	tallyItemVersionsByRepositoryName := OrderedDictionary new.
	{self sourceVersion. self targetVersion} do: [ :aSpaceTallyVersion |
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
GtSpaceTallyDiff >> sourceVersion [
	^ sourceVersion
]

{ #category : #accessing }
GtSpaceTallyDiff >> sourceVersion: aTallyVersion [
	sourceVersion := aTallyVersion
]

{ #category : #accessing }
GtSpaceTallyDiff >> targetVersion [
	^ targetVersion
]

{ #category : #accessing }
GtSpaceTallyDiff >> targetVersion: aTallyVersion [
	targetVersion :=aTallyVersion
]

{ #category : #accessing }
GtSpaceTallyDiff >> versionsOverviewData [
	^ { 
		'Instance count' -> {
			self sourceVersion totalInstCount.
			self targetVersion totalInstCount }.
		'Instances Size' -> {
			self sourceVersion totalInstSpace humanReadableIsqByteSize.
			self targetVersion totalInstSpace humanReadableIsqByteSize } }
]

{ #category : #accessing }
GtSpaceTallyDiff >> vmStatisticsDiffReport [ 
	^ GtVmRuntimeStatisticsDiffReport new
		sourceReport: self sourceVersion vmStatisticsReport;
		targetReport: self targetVersion vmStatisticsReport;
		yourself
]
