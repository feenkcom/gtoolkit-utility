"
This is a trait for defining basic utilities to be added to a typed group (a class that behaves like a collection, but is specific to a domain).
"
Trait {
	#name : 'TGtGroup',
	#category : 'GToolkit-Utility-System-GToolkit-Utility-System'
}

{ #category : 'accessing' }
TGtGroup >> asArray [
	^ self items asArray
]

{ #category : 'accessing' }
TGtGroup >> asOrderedCollection [
	^ self items asOrderedCollection
]

{ #category : 'accessing' }
TGtGroup >> at: anIndex [
	^ self items at: anIndex
]

{ #category : 'accessing' }
TGtGroup >> collect: aBlock [
	^ self items collect: aBlock
]

{ #category : 'accessing' }
TGtGroup >> do: aBlock [
	^ self items do: aBlock
]

{ #category : 'accessing' }
TGtGroup >> first [
	^ self items first
]

{ #category : 'accessing' }
TGtGroup >> groupedBy: aBlock [
	^ self items groupedBy: aBlock
]

{ #category : 'accessing' }
TGtGroup >> isCollection [
	^ true
]

{ #category : 'accessing' }
TGtGroup >> items [
	^ self explicitRequirement
]

{ #category : 'accessing' }
TGtGroup >> last [
	^ self items last
]

{ #category : 'accessing' }
TGtGroup >> reject: aBlock [
	^ self items reject: aBlock
]

{ #category : 'accessing' }
TGtGroup >> select: aBlock [
	^ self items select: aBlock
]

{ #category : 'accessing' }
TGtGroup >> size [
	^ self items size
]
