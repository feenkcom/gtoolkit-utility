Class {
	#name : #GtDummyItemBGroup,
	#superclass : #Object,
	#traits : 'TGtTypedGroupWithItems',
	#classTraits : 'TGtTypedGroupWithItems classTrait',
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyItemBGroup class >> containedType [
	^ GtDummyGroupBItem
]

{ #category : #'accessing - grouping' }
GtDummyItemBGroup >> groupedByValueB1 [
	^ self groupedBy: #valueB1
]

{ #category : #'accessing - grouping' }
GtDummyItemBGroup >> groupedByValueB2 [
	^ self groupedBy: #valueB2
]

{ #category : #'gt - extensions' }
GtDummyItemBGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Items';
		priority: 10;
		items: [ self ];
		column: 'Common Value Y' text: #commonValueY;
		column: 'Common Value Z' text: #commonValueZ;
		column: 'Specific Value B1' text: #valueB1;
		column: 'Specific Value B2' text: #valueB2
]

{ #category : #'gt - extensions' }
GtDummyItemBGroup >> gtViewByCommonValueB1For: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By ValueB1';
		priority: 30;
		items: [ self groupedByValueB1 associations ];
		column: 'Value' text: #key;
		column: 'Group' text: #value;
		send: #value
]

{ #category : #'gt - extensions' }
GtDummyItemBGroup >> gtViewByCommonValueB2For: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By ValueB2';
		priority: 35;
		items: [ self groupedByValueB2 associations ];
		column: 'Value' text: #key;
		column: 'Group' text: #value;
		send: #value
]
