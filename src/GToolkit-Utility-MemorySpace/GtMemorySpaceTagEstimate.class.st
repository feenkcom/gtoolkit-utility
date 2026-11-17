"
I hold the estimated memory of the objects with one tag (see {{gtClass:GtMemorySpaceTag}}) in a {{gtClass:GtMemorySpaceEstimate}}: their total bytes, and their bytes in each category as {{gtClass:GtMemorySpaceCategoryTagEstimate}} objects.

While a category says where memory comes from, a tag says what kind of objects it is made of. I am computed from the category estimates ({{gtClass:GtMemorySpaceCategoryEstimate}}) and share their tag estimates.
"
Class {
	#name : #GtMemorySpaceTagEstimate,
	#superclass : #Object,
	#instVars : [
		'tagName',
		'bytes',
		'categoryTagEstimates'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceTagEstimate class >> named: aTagName [
	^ self new
		tagName: aTagName;
		yourself
]

{ #category : #adding }
GtMemorySpaceTagEstimate >> addCategoryTagEstimate: aCategoryTagEstimate [
	"Add the bytes of the tag within one category"

	categoryTagEstimates add: aCategoryTagEstimate.
	bytes := bytes + aCategoryTagEstimate bytes
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> bytes [
	"The memory of the objects with the tag, over all categories"

	^ bytes
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> bytesOfCategory: aCategory [
	"The memory of the objects with the tag among the objects attributed to the category"

	^ (categoryTagEstimates
		detect: [ :each | each category = aCategory ]
		ifNone: [ nil ])
		ifNil: [ 0 ]
		ifNotNil: [ :aCategoryTagEstimate | aCategoryTagEstimate bytes ]
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> categories [
	"The categories with objects with the tag"

	^ categoryTagEstimates collect: [ :each | each category ]
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> categoryTagEstimates [
	"The estimates of the tag in each category (GtMemorySpaceCategoryTagEstimate)"

	^ categoryTagEstimates
]

{ #category : #'gt - extensions' }
GtMemorySpaceTagEstimate >> gtViewCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Categories';
		priority: 10;
		items: [ self sortedCategoryTagEstimates ];
		column: 'Category'
			text: [ :each | GtMemorySpaceCategory nameOf: each category ]
			width: 200;
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Percentage of the tag'
			text: [ :each | (each bytes * 100 / (bytes max: 1)) rounded asString , '%' ]
]

{ #category : #initialization }
GtMemorySpaceTagEstimate >> initialize [
	super initialize.
	bytes := 0.
	categoryTagEstimates := OrderedCollection new
]

{ #category : #printing }
GtMemorySpaceTagEstimate >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: tagName;
		nextPutAll: ': ';
		nextPutAll: bytes humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> sortedCategoryTagEstimates [
	"The estimates of the tag in each category, largest first"

	^ categoryTagEstimates asArray sort: [ :a :b | a bytes > b bytes ]
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> tagName [
	^ tagName
]

{ #category : #accessing }
GtMemorySpaceTagEstimate >> tagName: aTagName [
	tagName := aTagName
]
