"
I say which {{gtClass:GtMemorySpaceAttribution}} is used for the objects in one slot, in a {{gtClass:GtMemorySpaceSlotsAttribution}}.
"
Class {
	#name : #GtMemorySpaceSlotRule,
	#superclass : #GtMemorySpaceRule,
	#instVars : [
		'slotName'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceSlotRule class >> slot: aSlotName attribution: anAttribution [
	^ (self label: 'slot ' , aSlotName attribution: anAttribution)
		setSlotName: aSlotName
]

{ #category : #initialization }
GtMemorySpaceSlotRule >> setSlotName: aSlotName [
	slotName := aSlotName
]

{ #category : #accessing }
GtMemorySpaceSlotRule >> slotName [
	^ slotName
]
