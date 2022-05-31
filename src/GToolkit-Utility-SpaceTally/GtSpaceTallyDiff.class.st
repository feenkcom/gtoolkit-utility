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

{ #category : #accessing }
GtSpaceTallyDiff >> gtViewAnalyzedClassesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Class Changes';
		priority: 20;
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

{ #category : #accessing }
GtSpaceTallyDiff >> gtViewAnalyzedPackagesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Package Changes';
		priority: 15;
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
					aPackageHistory instanceSizeChange humanReadableIsqByteSize ])
			
			 ];
		column: 'Latest Count' text: [ :aPackageHistory |
			aPackageHistory tallyItemVersions last totalInstCount ];
		column: 'Latest Size' text: [ :aPackageHistory |
			aPackageHistory tallyItemVersions last totalInstSpace humanReadableIsqByteSize ]
		
]

{ #category : #accessing }
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

{ #category : #accessing }
GtSpaceTallyDiff >> gtViewVersionsOverviewFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Versions Overview';
		priority: 10;
		items: [ self versionsOverviewData ];
		column: 'Property' text: [ :assoc |
			assoc key ];
		column: 'Source Version' text: [ :assoc |
			assoc value first ];
		column: 'Target Version' text: [ :assoc |
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
