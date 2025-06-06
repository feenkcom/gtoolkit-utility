"
This is a trait for defining basic utilities to be added to a typed group (a class that behaves like a collection, but is specific to a domain).
"
Trait {
	#name : #TGtGroup,
	#category : #'GToolkit-Utility-System-GToolkit-Utility-System'
}

{ #category : #accessing }
TGtGroup >> anyOne [
	^ self items anyOne
]

{ #category : #accessing }
TGtGroup >> anySatisfy: aBlock [
	^ self items anySatisfy: aBlock
]

{ #category : #accessing }
TGtGroup >> asArray [
	^ self items asArray
]

{ #category : #accessing }
TGtGroup >> asAsyncStream [
	^ AsyncSequenceStream forCollection: self
]

{ #category : #accessing }
TGtGroup >> asBag [
	^ self items asBag
]

{ #category : #accessing }
TGtGroup >> asBrItemsProvider [
	^ BrSequenceableCollectionItemsProvider forCollection: self
]

{ #category : #accessing }
TGtGroup >> asOrderedCollection [
	^ self items asOrderedCollection
]

{ #category : #accessing }
TGtGroup >> asSortedCollection: aBlock [
	^ self items asSortedCollection: aBlock
]

{ #category : #accessing }
TGtGroup >> at: anIndex [
	^ self items at: anIndex
]

{ #category : #enumerating }
TGtGroup >> collect: aBlock [
	^ self items collect: aBlock
]

{ #category : #enumerating }
TGtGroup >> collect: aBlock as: aClass [
	^ self items 
		collect: aBlock as: aClass
]

{ #category : #enumerating }
TGtGroup >> collect: collectBlock thenReject: selectBlock [
	^ self items collect: collectBlock thenReject: selectBlock
]

{ #category : #enumerating }
TGtGroup >> collect: collectBlock thenSelect: selectBlock [
	^ self items collect: collectBlock thenSelect: selectBlock
]

{ #category : #enumerating }
TGtGroup >> collectWithIndex: aBlock [
	^ self items collectWithIndex: aBlock
]

{ #category : #enumerating }
TGtGroup >> detect: aBlock [ 
	^ self items detect: aBlock 
]

{ #category : #enumerating }
TGtGroup >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ self items 
		detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : #enumerating }
TGtGroup >> detect: aBlock ifNone: exceptionBlock [
	^ self items 
		detect: aBlock ifNone: exceptionBlock
]

{ #category : #accessing }
TGtGroup >> detectIndex: aBlock [
	^ self items detectIndex: aBlock
]

{ #category : #accessing }
TGtGroup >> detectIndex: aBlock ifNone: exceptionBlock [
	^ self items detectIndex: aBlock ifNone: exceptionBlock
]

{ #category : #enumerating }
TGtGroup >> detectMax: aBlock [ 
	^ self items detectMax: aBlock 
]

{ #category : #enumerating }
TGtGroup >> detectMin: aBlock [ 
	^ self items detectMin: aBlock 
]

{ #category : #accessing }
TGtGroup >> do: aBlock [
	^ self items do: aBlock
]

{ #category : #'compatibility - DeepTraverser' }
TGtGroup >> dtRawTraverseUsing: aStream [
	self do: [ :each | aStream traverse: each ]
]

{ #category : #'compatibility - DeepTraverser' }
TGtGroup >> dtTraverseStartUsing: aStream [
	self do: [ :each | each dtTraverseStartUsing: aStream ]
]

{ #category : #'compatibility - DeepTraverser' }
TGtGroup >> dtTraverseUsing: aStream [
	self do: [ :each | each dtTraverseUsing: aStream ]
]

{ #category : #accessing }
TGtGroup >> first [
	^ self items first
]

{ #category : #accessing }
TGtGroup >> first: aCount [
	^ self species 
		withAll: (self items first: aCount)
]

{ #category : #accessing }
TGtGroup >> flatCollect: aBlock [
	^ self items flatCollect: aBlock
]

{ #category : #accessing }
TGtGroup >> flatCollect: aBlock as: aClass [
	^ self items flatCollect: aBlock as: aClass
]

{ #category : #accessing }
TGtGroup >> groupedBy: aBlock [
	^ self items groupedBy: aBlock
]

{ #category : #accessing }
TGtGroup >> groupedBy: aBlock having: conditionBlock [
	^ self items groupedBy: aBlock having: conditionBlock
]

{ #category : #testing }
TGtGroup >> identityIncludes: anObject [
	^ self items identityIncludes: anObject
]

{ #category : #testing }
TGtGroup >> ifEmpty: aBlock [
	^ self items ifEmpty: aBlock
]

{ #category : #testing }
TGtGroup >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	^ self items ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock
]

{ #category : #testing }
TGtGroup >> ifNotEmpty: aBlock [
	^ self items ifNotEmpty: aBlock
]

{ #category : #testing }
TGtGroup >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [
	^ self items ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock
]

{ #category : #testing }
TGtGroup >> includes: anObject [
	^ self items includes: anObject
]

{ #category : #accessing }
TGtGroup >> indexOf: aBlock [
	^ self items indexOf: aBlock
]

{ #category : #accessing }
TGtGroup >> inject: anObject into: aBlock [
	^ self items inject: anObject into: aBlock
]

{ #category : #accessing }
TGtGroup >> isCollection [
	^ true
]

{ #category : #testing }
TGtGroup >> isEmpty [

	^ self items isEmpty
]

{ #category : #testing }
TGtGroup >> isEmptyOrNil [
	^ self items isEmptyOrNil
]

{ #category : #testing }
TGtGroup >> isNotEmpty [

	^ self items isNotEmpty
]

{ #category : #accessing }
TGtGroup >> items [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtGroup >> last [
	^ self items last
]

{ #category : #accessing }
TGtGroup >> last: aCount [
	^ self species 
		withAll: (self items last: aCount)
]

{ #category : #accessing }
TGtGroup >> overlappingPairsDo: aBlock [
	^ self items overlappingPairsDo: aBlock
]

{ #category : #printing }
TGtGroup >> printOn: aStream [
	super printOn: aStream.
	
	aStream 
		<< ' [';
		print: self size;
		<< ' ';
		<< (self size = 1 
			ifTrue: [ 'item' ]
			ifFalse: [ 'items' ]);
		<< ']'
]

{ #category : #accessing }
TGtGroup >> reject: aBlock [
	^ self items reject: aBlock
]

{ #category : #accessing }
TGtGroup >> remove: anItem [
	self items remove: anItem
]

{ #category : #accessing }
TGtGroup >> removeAll [
	self items removeAll
]

{ #category : #accessing }
TGtGroup >> removeLast [
	self items removeLast
]

{ #category : #accessing }
TGtGroup >> reversed [
	^ self items reversed
]

{ #category : #accessing }
TGtGroup >> select: aBlock [
	^ self items select: aBlock
]

{ #category : #accessing }
TGtGroup >> size [
	^ self items size
]

{ #category : #accessing }
TGtGroup >> sorted: aPredicate [
	^ self items sorted: aPredicate
]

{ #category : #accessing }
TGtGroup >> withIndexCollect: aBlock [
	^ self items withIndexCollect: aBlock
]

{ #category : #accessing }
TGtGroup >> withIndexDo: aBlock [
	^ self items withIndexDo: aBlock
]
