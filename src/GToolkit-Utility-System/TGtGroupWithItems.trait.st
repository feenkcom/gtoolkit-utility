Trait {
	#name : #TGtGroupWithItems,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
TGtGroupWithItems >> allButFirst [
	^ self species withAll: self items allButFirst
]

{ #category : #accessing }
TGtGroupWithItems >> allButLast [
	^ self species withAll: self items allButLast
]

{ #category : #accessing }
TGtGroupWithItems >> asSet [
	^ self items asSet
]

{ #category : #accessing }
TGtGroupWithItems >> asStringOn: aStream delimiter: delimString [

	self items asStringOn: aStream delimiter: delimString
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

{ #category : #printing }
TGtGroupWithItems >> printOn: aStream [
	super printOn: aStream.

	"Always printing the size can force items to be calculated,
	which can trigger mutex deadlocks when debugging."
	items ifNil: [ ^ self ].
	aStream 
		<< ' [';
		print: self size;
		<< ' ';
		<< (self size = 1 
			ifTrue: [ 'item' ]
			ifFalse: [ 'items' ]);
		<< ']'
]

{ #category : #enumerating }
TGtGroupWithItems >> reject: aBlock [
	^ self species 
		withAll: (self items reject: aBlock)
]

{ #category : #enumerating }
TGtGroupWithItems >> reversed [
	^ self species 
		withAll: (self items reversed)
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
