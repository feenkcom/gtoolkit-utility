Class {
	#name : #GtBeaconLogEventsGroup,
	#superclass : #Object,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit-Utility-Logging'
}

{ #category : #adding }
GtBeaconLogEventsGroup >> addAll: aCollection [
	self items addAll: aCollection
]

{ #category : #accessing }
GtBeaconLogEventsGroup >> allSignals [
	^ GtBeaconSignalsGroup 
		withAll: (self items flatCollect: #allSignals)
]

{ #category : #'gt - extensions' }
GtBeaconLogEventsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Events';
		priority: 10;
		items: [ self ];
		children: #subEvents;
		column: 'Event Type' text: [ :anEvent | anEvent class eventLabel ];
		column: 'Timestamp' text: #timestamp;
		column: 'Duration' 
			text: [ :anEvent | anEvent duration ]
]

{ #category : #enumerating }
GtBeaconLogEventsGroup >> inject: thisValue into: binaryBlock [
	^ self items 
		inject: thisValue into: binaryBlock
]

{ #category : #'math functions' }
GtBeaconLogEventsGroup >> sumDurations: aBlock [
	^ self  
		inject: 0 seconds 
		into: [ :total  :anEventsGrouper | 
			total + (aBlock value: anEventsGrouper) ]
]

{ #category : #'math functions' }
GtBeaconLogEventsGroup >> sumNumbers: aBlock [
	^ self items sumNumbers: aBlock
]
