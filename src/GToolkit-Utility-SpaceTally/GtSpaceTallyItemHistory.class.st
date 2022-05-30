Class {
	#name : #GtSpaceTallyItemHistory,
	#superclass : #Object,
	#instVars : [
		'tallyItemVersions'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyItemHistory >> addTallyItemVersion: aTallyItemVersion [

	self tallyItemVersions add: aTallyItemVersion 
]

{ #category : #accessing }
GtSpaceTallyItemHistory >> firstVersion [
	^ self tallyItemVersions first
]

{ #category : #'gt - extensions' }
GtSpaceTallyItemHistory >> gtViewTallVersionsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Versions';
		items: [ self tallyItemVersions ];
		column: 'Version' text: [ :aClassTallyVersion | aClassTallyVersion tallyVersion index ];
		column: 'Instance Count' text: [ :aClassTallyVersion |
			aClassTallyVersion totalInstCount ];
		column: 'Instances Size' text: [ :aClassTallyVersion |
			aClassTallyVersion totalInstSpace humanReadableIsqByteSize ]
]

{ #category : #testing }
GtSpaceTallyItemHistory >> hasChanges [
	^ self hasInstanceCountChange or: [
		self hasSizeChange ]
]

{ #category : #testing }
GtSpaceTallyItemHistory >> hasInstanceCountChange [
	^ (self tallyItemVersions collectAsSet: [ :aTallyVersion |
		aTallyVersion totalInstSpace ]) size > 1
]

{ #category : #testing }
GtSpaceTallyItemHistory >> hasSizeChange [
	^ (self tallyItemVersions collectAsSet: [ :aTallyVersion |
		aTallyVersion totalInstSpace ]) size > 1
]

{ #category : #initialization }
GtSpaceTallyItemHistory >> initialize [ 
	super initialize.
	tallyItemVersions := OrderedCollection new.
]

{ #category : #accessing }
GtSpaceTallyItemHistory >> instanceCountChange [
	^ self latestVersion totalInstCount - self firstVersion totalInstCount
]

{ #category : #accessing }
GtSpaceTallyItemHistory >> instanceSizeChange [
	^ self latestVersion totalInstSpace - self firstVersion totalInstSpace
]

{ #category : #accessing }
GtSpaceTallyItemHistory >> latestVersion [
	^ self tallyItemVersions last
]

{ #category : #accessing }
GtSpaceTallyItemHistory >> tallyItemVersions [
	^ tallyItemVersions
]
