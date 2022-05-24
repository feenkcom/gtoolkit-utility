Extension { #name : #SpaceTally }

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTally >> gtViewItemsFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ results ];
		view: #gtViewItemsFor:
]

{ #category : #'*GToolkit-Utility-SpaceTally' }
SpaceTally >> gtViewOverviewFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Overview';
		object: [ results ];
		view: #gtViewOverviewFor:
]
