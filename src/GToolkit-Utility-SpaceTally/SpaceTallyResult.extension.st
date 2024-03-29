Extension { #name : #SpaceTallyResult }

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTallyResult >> gtOverviewData [
	^ { 
		'Instance count' -> self totalInstCount.
		"'Code Size' -> self totalCodeSpace humanReadableIsqByteSize."
		'Instances Size' -> self totalInstSpace humanReadableIsqByteSize }
]

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTallyResult >> gtViewItemsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Items';
		items:  [ items sorted: [ :aSpaceTallyItem | 
			aSpaceTallyItem spaceForInstances ] descending ];
		column: 'Class' text: [ :aSpaceTallyItem | aSpaceTallyItem analyzedClassName ];
		"column: 'Code Size' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem codeSize humanReadableIsqByteSize ];"
		column: 'Instance count' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem instanceCount ];
		column: 'Instances Size' text: [ :aSpaceTallyItem | 
			aSpaceTallyItem spaceForInstances humanReadableIsqByteSize ]
]

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTallyResult >> gtViewOverviewFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Overview';
		items:  [ self gtOverviewData ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]
