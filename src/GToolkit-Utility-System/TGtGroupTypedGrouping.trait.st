Trait {
	#name : #TGtGroupTypedGrouping,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
TGtGroupTypedGrouping >> addTypeAt: aKey for: anEntity to: groupedTypes [ 
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
TGtGroupTypedGrouping >> groupedWithTypeBy: aBlockClosure [ 
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
