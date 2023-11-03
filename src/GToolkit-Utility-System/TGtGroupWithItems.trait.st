Trait {
	#name : #TGtGroupWithItems,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit-Utility-System'
}

{ #category : #enumerating }
TGtGroupWithItems >> collect: aBlock [
	^ self species withAll: (self items collect: aBlock)
]

{ #category : #enumerating }
TGtGroupWithItems >> collect: collectBlock thenReject: selectBlock [
	^ self species
		withAll: (self items collect: collectBlock thenReject: selectBlock)
]

{ #category : #enumerating }
TGtGroupWithItems >> collect: collectBlock thenSelect: selectBlock [
	^ self species
		withAll: (self items collect: collectBlock thenSelect: selectBlock)
]

{ #category : #enumerating }
TGtGroupWithItems >> collectWithIndex: aBlock [
	^ self species withAll: (self items collectWithIndex: aBlock)
]

{ #category : #accessing }
TGtGroupWithItems >> groupedBy: aBlock [ 
	"Override this method here and not reuse the one in collection
	because we want the keys to be groups, not simple collections"
	
	| result |
	result := Dictionary new.
	self do:[:each | 
		| key collection |
		key := aBlock value: each.
		collection := result at: key ifAbsentPut: [ OrderedCollection new].
		collection add: each].
		
	result keysAndValuesDo: [:key :value | 
		result at: key put: (self species withAll: value)].

	^result
]

{ #category : #accessing }
TGtGroupWithItems >> groupedBy: aBlock having: conditionBlock [ 
	"Override this method here and not reuse the one in collection
	because we want the keys to be groups, not simple collections"
	
	^ (self groupedBy: aBlock) select: conditionBlock
]

{ #category : #enumerating }
TGtGroupWithItems >> reject: aBlock [
	^ self species 
		withAll: (self items reject: aBlock)
]

{ #category : #enumerating }
TGtGroupWithItems >> select: aBlock [
	^ self species 
		withAll: (self items select: aBlock)
]

{ #category : #sorting }
TGtGroupWithItems >> sorted: aPredicate [
	^ self species withAll: (self items sorted: aPredicate)
]
