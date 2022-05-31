Class {
	#name : #GtSpaceTallyPackageTallyVersion,
	#superclass : #GtSpaceTallyItemTallyVersion,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyPackageTallyVersion >> analyzedPackageName [
	^ self tallyItem analyzedPackageName
]

{ #category : #'gt - extensions' }
GtSpaceTallyPackageTallyVersion >> gtViewTallyItemsFor: aView [
	<gtView>
	tallyItem ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ tallyItem ];
		view: #gtViewTallyItemsFor:
]

{ #category : #'gt - extensions' }
GtSpaceTallyPackageTallyVersion >> gtViewTallyOverviewFor: aView [
	<gtView>
	tallyItem ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Overview';
		object: [ tallyItem ];
		view: #gtViewTallyOverviewFor:
]

{ #category : #accessing }
GtSpaceTallyPackageTallyVersion >> spaceTallyClassVersions [
	^ self tallyItem classTallies items collect: [ :aTallyResult |
		GtSpaceTallyClassTallyVersion new
			tallyVersion: self tallyVersion;
			tallyItem: aTallyResult ] 
]
