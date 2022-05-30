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
		items: [ self versionsOverviewData ];
		column: 'Property' text: [ :assoc |
			assoc key ];
		column: 'Source Version' text: [ :assoc |
			assoc value first ];
		column: 'Target Version' text: [ :assoc |
			assoc value second ]
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
