"
I decide to which categories ({{gtClass:GtMemorySpaceCategory}}) the memory of an object, and of the objects reachable from it, is attributed.

My subclasses are declared once and reused for many objects:
- {{gtClass:GtMemorySpaceCategoryAttribution}} attributes everything reachable to one category;
- {{gtClass:GtMemorySpaceIgnoredAttribution}} does not count anything;
- {{gtClass:GtMemorySpaceSlotsAttribution}} attributes an object to a category, and each of its slots with its own attribution;
- {{gtClass:GtMemorySpaceDictionaryAttribution}} does the same for the keys of a dictionary.

An attribution estimates with #estimate:with:into:, using a {{gtClass:GtMemorySpaceEstimator}}, which counts every object only once.
"
Class {
	#name : #GtMemorySpaceAttribution,
	#superclass : #Object,
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceAttribution class >> ignored [
	"Do not count anything"

	^ GtMemorySpaceIgnoredAttribution new
]

{ #category : #'instance creation' }
GtMemorySpaceAttribution class >> toCategory: aCategory [
	"Attribute everything reachable to aCategory"

	^ GtMemorySpaceCategoryAttribution new category: aCategory
]

{ #category : #accessing }
GtMemorySpaceAttribution >> categories [
	"All categories to which I can attribute memory"

	| allCategories |
	allCategories := OrderedCollection new.
	self
		categoriesDo: [ :each | (allCategories includes: each) ifFalse: [ allCategories add: each ] ].
	^ allCategories
]

{ #category : #accessing }
GtMemorySpaceAttribution >> categoriesDo: aBlock [
	self subclassResponsibility
]

{ #category : #estimating }
GtMemorySpaceAttribution >> estimate: anObject with: anEstimator into: anEstimate [
	"Add the memory of anObject, and of the objects reachable from it that were not counted before, 
	to the categories of anEstimate"

	self subclassResponsibility
]

{ #category : #'gt - extensions' }
GtMemorySpaceAttribution >> gtViewCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Categories';
		priority: 20;
		items: [ self categories ];
		column: 'Category'
			text: [ :each | GtMemorySpaceCategory nameOf: each ]
			width: 200;
		column: 'Description'
			text: [ :each | 
				(each isKindOf: GtMemorySpaceCategory)
					ifTrue: [ each description ]
					ifFalse: [ '' ] ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceAttribution >> gtViewRulesFor: aView [
	<gtView>
	self rules ifEmpty: [ ^ aView empty ].

	^ aView columnedTree
		title: 'Rules';
		priority: 10;
		items: [ self rules ];
		children: [ :each | each rules ];
		column: 'Part'
			text: [ :each | each label ]
			width: 200;
		column: 'Attribution' text: [ :each | each summary ];
		send: [ :each | each attribution ]
]

{ #category : #printing }
GtMemorySpaceAttribution >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self summary;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceAttribution >> rules [
	"The rules for the parts of an object (GtMemorySpaceRule), for views"

	^ #()
]

{ #category : #accessing }
GtMemorySpaceAttribution >> summary [
	"A one line description, for views"

	^ self subclassResponsibility
]
