Extension { #name : #SpaceTallyResult }

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
