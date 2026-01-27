Class {
	#name : #GtDummyItemAGroup,
	#superclass : #GtDummyItemGroup,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyItemAGroup class >> containedType [
	^ GtDummyGroupAItem
]

{ #category : #'accessing - grouping' }
GtDummyItemAGroup >> groupedByValueA [
	^ self groupedBy: #valueA
]

{ #category : #'gt - extensions' }
GtDummyItemAGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Items';
		priority: 10;
		items: [ self ];
		column: 'Common Value Y' text: #commonValueY;
		column: 'Common Value Z' text: #commonValueZ;
		column: 'Specific Value A' text: #valueA
]

{ #category : #'gt - extensions' }
GtDummyItemAGroup >> gtViewByCommonValueZFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By ValueA';
		priority: 30;
		items: [ self groupedByValueA associations ];
		column: 'Value' text: #key;
		column: 'Group' text: #value;
		send: #value
]
