Class {
	#name : #GtBeaconSignalsGroup,
	#superclass : #Object,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit-Utility-Logging'
}

{ #category : #adding }
GtBeaconSignalsGroup >> addAll: aCollection [
	self items addAll: aCollection
]

{ #category : #'gt - extensions' }
GtBeaconSignalsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Signals';
		priority: 10;
		object: [ self items ];
		view: #gtItemsFor:
]
