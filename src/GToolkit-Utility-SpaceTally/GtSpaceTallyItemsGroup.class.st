Class {
	#name : #GtSpaceTallyItemsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #views }
GtSpaceTallyItemsGroup >> gtOverviewData [
	^ { 
		'Instance count' -> self totalInstCount.
		"'Code Size' -> self totalCodeSpace humanReadableIsqByteSize."
		'Instances Size' -> self totalInstSpace humanReadableIsqByteSize }
]

{ #category : #views }
GtSpaceTallyItemsGroup >> gtViewItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Items';
		items:  [ items sorted: [ :aSpaceTallyItem | 
			aSpaceTallyItem spaceForInstances ] descending ];
		column: 'Class' text: [ :aSpaceTallyItem | aSpaceTallyItem analyzedClassName ];
		"column: 'Code Size' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem codeSize humanReadableIsqByteSize ];"
		column: 'Instance count' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem printObjectsSize ];
		column: 'Instances Size' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem printObjectsByteSize ]
]

{ #category : #views }
GtSpaceTallyItemsGroup >> gtViewOverviewFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Overview';
		items:  [ self gtOverviewData ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtSpaceTallyItemsGroup >> totalCodeSpace [
	^ self items sum: [ :each | each codeSize ]
]

{ #category : #accessing }
GtSpaceTallyItemsGroup >> totalInstCount [
	^ self items sum: #instanceCount
]

{ #category : #accessing }
GtSpaceTallyItemsGroup >> totalInstSpace [
	^ self items sum: #spaceForInstances
]
