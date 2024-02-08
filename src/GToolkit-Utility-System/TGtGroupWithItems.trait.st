Trait {
	#name : #TGtGroupWithItems,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
TGtGroupWithItems >> addTypeAt: aKey for: anEntity to: groupedTypes [ 
	| entityGroupType currentGroupType |
	entityGroupType := anEntity class gtGroupType.
	currentGroupType := groupedTypes 
		at: aKey
		ifAbsent: [ 
			groupedTypes at: aKey put: entityGroupType.
			^ self ].
			
	"No need to do anything if the new entity has the same type"
	entityGroupType = currentGroupType ifTrue: [ ^ self].
	
	"Handle a new type that is a superclass of the existing type"
	(currentGroupType inheritsFrom: entityGroupType)
		ifTrue: [ 
			groupedTypes 
				at: aKey
				put: entityGroupType.
			^ self ].
			
	groupedTypes 
		at: aKey
		put: self class.
]

{ #category : #accessing }
TGtGroupWithItems >> asSet [
	^ self items asSet
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

{ #category : #accessing }
TGtGroupWithItems >> groupedWithTypeBy: aBlockClosure [ 
	| groupedEntities groupedTypes |
	groupedEntities := Dictionary new.
	groupedTypes := Dictionary new.
	
	self do:[:each | 
		| key collection |
		key := aBlockClosure value: each.
		collection := groupedEntities at: key ifAbsentPut: [ OrderedCollection new].
		self addTypeAt: key for: each to: groupedTypes.
		collection add: each ].
			
	groupedEntities keysAndValuesDo: [:key :value | 
		groupedEntities at: key put: ((groupedTypes at: key) withAll: value)].
		
	^ groupedEntities
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
