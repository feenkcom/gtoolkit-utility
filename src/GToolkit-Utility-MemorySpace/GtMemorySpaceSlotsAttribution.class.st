"
I attribute an object to my object category, the objects reachable from each of its named slots with the attribution of that slot, and the objects reachable from its indexed slots with my attribution for other slots. Each slot with its own attribution has a {{gtClass:GtMemorySpaceSlotRule}}; my slot rules are indexed by slot name, as they are looked up for every slot of every estimated object. Slots without a rule use my attribution for other slots, which by default attributes them to my object category.

The object is counted even if the boundary of the estimation stops at its class; the boundary applies to the objects reached from its slots. Like the walk of the estimator, I do not follow the key of an ephemeron, weak references, or slots holding raw data.
"
Class {
	#name : #GtMemorySpaceSlotsAttribution,
	#superclass : #GtMemorySpaceAttribution,
	#instVars : [
		'objectCategory',
		'objectAttribution',
		'slotRules',
		'otherSlotsAttribution'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> attributionForSlot: aSlotName [
	^ (self ruleForSlot: aSlotName)
		ifNil: [ self otherSlotsAttribution ]
		ifNotNil: [ :aRule | aRule attribution ]
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> categoriesDo: aBlock [
	aBlock value: objectCategory.
	slotRules do: [ :each | each attribution categoriesDo: aBlock ].
	self otherSlotsAttribution categoriesDo: aBlock
]

{ #category : #estimating }
GtMemorySpaceSlotsAttribution >> estimate: anObject with: anEstimator into: anEstimate [
	"Count anObject, then attribute the objects in its named slots with their attributions,
	and the objects in its indexed slots with the attribution for other slots.
	Like the walk of the estimator, the key of an ephemeron and weak references are not followed."

	| aTraversal aSlotNames |
	(anEstimator shouldCountExplicitly: anObject) ifFalse: [ ^ self ].

	anEstimator
		estimateObject: anObject
		inCategory: objectCategory
		into: anEstimate.
	aTraversal := anEstimator traversalForClass: anObject class.
	aSlotNames := aTraversal slotNames.
	aTraversal firstSlotIndex
		to: aTraversal lastSlotIndex
		do: [ :anIndex | 
			(self attributionForSlot: (aSlotNames at: anIndex))
				estimate: (anObject instVarAt: anIndex)
				with: anEstimator
				into: anEstimate ].
	aTraversal followsIndexedSlots
		ifTrue: [ 1
				to: anObject basicSize
				do: [ :anIndex | 
					self otherSlotsAttribution
						estimate: (anObject basicAt: anIndex)
						with: anEstimator
						into: anEstimate ] ]
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> ignoreSlots: aCollectionOfSlotNames [
	"Do not count the objects in these slots"

	| anAttribution |
	anAttribution := GtMemorySpaceAttribution ignored.
	aCollectionOfSlotNames do: [ :each | self slot: each by: anAttribution ]
]

{ #category : #initialization }
GtMemorySpaceSlotsAttribution >> initialize [
	super initialize.
	slotRules := OrderedDictionary new
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> objectAttribution [
	"Attributes everything to the category of the object"

	^ objectAttribution
		ifNil: [ objectAttribution := GtMemorySpaceAttribution toCategory: objectCategory ]
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> objectCategory [
	^ objectCategory
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> objectCategory: aCategory [
	"The category of the object itself"

	objectCategory := aCategory.
	objectAttribution := nil
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> otherSlotsAttribution [
	"By default, slots without an explicit attribution go to the category of the object"

	^ otherSlotsAttribution ifNil: [ self objectAttribution ]
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> otherSlotsBy: anAttribution [
	otherSlotsAttribution := anAttribution
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> otherSlotsTo: aCategory [
	"Attribute the slots without an explicit attribution to aCategory"

	self otherSlotsBy: (GtMemorySpaceAttribution toCategory: aCategory)
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> ruleForSlot: aSlotName [
	"The rule of the slot, or nil if the slot uses the attribution for other slots"

	^ slotRules at: aSlotName ifAbsent: nil
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> rules [
	^ Array
		streamContents: [ :aStream | 
			aStream
				nextPut: (GtMemorySpaceRule
						label: 'the object itself'
						attribution: self objectAttribution).
			aStream nextPutAll: self slotRules.
			aStream
				nextPut: (GtMemorySpaceRule label: 'other slots' attribution: self otherSlotsAttribution) ]
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> slot: aSlotName by: anAttribution [
	"Attribute the object in the slot with anAttribution"

	slotRules
		at: aSlotName asSymbol
		put: (GtMemorySpaceSlotRule slot: aSlotName asSymbol attribution: anAttribution)
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> slot: aSlotName to: aCategory [
	"Attribute everything reachable from the slot to aCategory"

	self slot: aSlotName by: (GtMemorySpaceAttribution toCategory: aCategory)
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> slotRules [
	"The rules of the slots with their own attribution (GtMemorySpaceSlotRule)"

	^ slotRules values
]

{ #category : #declaring }
GtMemorySpaceSlotsAttribution >> slots: aCollectionOfSlotNames to: aCategory [
	| anAttribution |
	anAttribution := GtMemorySpaceAttribution toCategory: aCategory.
	aCollectionOfSlotNames do: [ :each | self slot: each by: anAttribution ]
]

{ #category : #accessing }
GtMemorySpaceSlotsAttribution >> summary [
	^ 'split by slots, the object to '
		, (GtMemorySpaceCategory nameOf: objectCategory)
]
