Class {
	#name : #GtBeaconSignalsGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #'gt - extensions' }
GtBeaconSignalsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Signals';
		priority: 10;
		object: [ self items ];
		view: #gtItemsFor:
]
