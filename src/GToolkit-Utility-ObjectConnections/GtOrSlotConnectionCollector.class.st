Class {
	#name : #GtOrSlotConnectionCollector,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #accessing }
GtOrSlotConnectionCollector >> collectForObjects: aCollection [
	| containmentRelations |
	containmentRelations := OrderedCollection new.
	
	aCollection do: [ :each |
		each class allSlots do: [:aSlot |
			| currentSlotValue|
			currentSlotValue := each readSlot: aSlot.
			(aCollection anySatisfy: [ :e | e == currentSlotValue ])
				ifTrue: [ 
					containmentRelations add: (GtOrSlotConnection new 
						targetObject: each;
						slotName: aSlot name;
						slotValue: currentSlotValue) ] ] ].
	
	^ containmentRelations
]
