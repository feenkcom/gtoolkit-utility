Trait {
	#name : #TGtGroupItems,
	#instVars : [
		'items'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance - creation' }
TGtGroupItems classSide >> withAll: aCollection [
	^ self new 
		initializeWith: aCollection
]

{ #category : #accessing }
TGtGroupItems >> add: anItem [
	self items add: anItem
]

{ #category : #accessing }
TGtGroupItems >> addAll: aCollection [
	self items addAll: aCollection
]

{ #category : #accessing }
TGtGroupItems >> addItem: anItem [
	self items add: anItem
]

{ #category : #accessing }
TGtGroupItems >> addItems: aCollection [
	self items addAll: aCollection
]

{ #category : #initialization }
TGtGroupItems >> initializeWith: aCollection [
	items := aCollection
]

{ #category : #accessing }
TGtGroupItems >> items [
	^ items ifNil: [
		items := OrderedCollection new ]
]
