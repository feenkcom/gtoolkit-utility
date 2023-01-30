Class {
	#name : #GtGhIssuesGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #'gt - extensions' }
GtGhIssuesGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Items';
		items: [ self ];
		column: 'Reference' text: [ :anIssue | anIssue shortReference ] width: 200;
		column: 'Title' text: [ :anIssue | anIssue title ];
		column: 'State' text: [ :anIssue | anIssue state ] width: 75
]
