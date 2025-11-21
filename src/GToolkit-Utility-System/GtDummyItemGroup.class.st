Class {
	#name : #GtDummyItemGroup,
	#superclass : #Object,
	#traits : 'TGtTypedGroupWithItems',
	#classTraits : 'TGtTypedGroupWithItems classTrait',
	#category : 'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyItemGroup class >> containedType [
	^ GtDummyRootGroupItem
]

{ #category : #'accessing - grouping' }
GtDummyItemGroup >> groupedByCommonValueY [
	^ self groupedBy: #commonValueY
]

{ #category : #'accessing - grouping' }
GtDummyItemGroup >> groupedByCommonValueZ [
	^ self groupedBy: #commonValueZ
]

{ #category : #'gt - extensions' }
GtDummyItemGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Items';
		priority: 10;
		items: [ self ];
		column: 'Common Value Y' text: #commonValueY;
		column: 'Common Value Z' text: #commonValueZ;
		column: 'Type' text: #className
]

{ #category : #'gt - extensions' }
GtDummyItemGroup >> gtViewByCommonValueYFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By ValueY';
		priority: 20;
		items: [ self groupedByCommonValueY associations ];
		column: 'Value' text: #key;
		column: 'Group' text: #value;
		send: #value
]

{ #category : #'gt - extensions' }
GtDummyItemGroup >> gtViewByCommonValueZFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By ValueZ';
		priority: 25;
		items: [ self groupedByCommonValueZ associations ];
		column: 'Value' text: #key;
		column: 'Group' text: #value;
		send: #value
]
