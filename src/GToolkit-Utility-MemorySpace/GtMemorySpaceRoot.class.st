"
I am an object from which memory is estimated, with a label describing where it comes from, for example 'Symbol class var SymbolTable'.

I can name the category to which my memory goes, for example the package of the class holding me. Without a category name, my {{gtClass:GtMemorySpaceRootGroup}} decides.
"
Class {
	#name : #GtMemorySpaceRoot,
	#superclass : #Object,
	#instVars : [
		'label',
		'object',
		'categoryName'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceRoot class >> label: aString object: anObject [
	^ self
		label: aString
		object: anObject
		categoryName: nil
]

{ #category : #'instance creation' }
GtMemorySpaceRoot class >> label: aString object: anObject categoryName: aCategoryName [
	^ self new
		setLabel: aString
		object: anObject
		categoryName: aCategoryName
]

{ #category : #accessing }
GtMemorySpaceRoot >> categoryName [
	"The name of the category of my memory, or nil to use the category of my group"

	^ categoryName
]

{ #category : #accessing }
GtMemorySpaceRoot >> label [
	^ label
]

{ #category : #accessing }
GtMemorySpaceRoot >> object [
	^ object
]

{ #category : #printing }
GtMemorySpaceRoot >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (label ifNil: [ '' ]);
		nextPut: $)
]

{ #category : #initialization }
GtMemorySpaceRoot >> setLabel: aString object: anObject categoryName: aCategoryName [
	label := aString.
	object := anObject.
	categoryName := aCategoryName
]
