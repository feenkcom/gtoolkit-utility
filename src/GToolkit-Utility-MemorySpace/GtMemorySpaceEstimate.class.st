"
I hold the result of estimating memory space with a {{gtClass:GtMemorySpaceEstimator}}: one {{gtClass:GtMemorySpaceCategoryEstimate}} per category, with the bytes and the number of objects attributed to the category, and the bytes of tagged objects among them (see {{gtClass:GtMemorySpaceTag}}).

Categories are usually {{gtClass:GtMemorySpaceCategory}} objects declared by a {{gtClass:GtMemorySpaceDefinition}}, but any object can be used as a category, for example a symbol.
"
Class {
	#name : #GtMemorySpaceEstimate,
	#superclass : #Object,
	#instVars : [
		'categoryEstimates',
		'rootEstimates',
		'totalBytes',
		'totalObjectsCount'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceEstimate class >> forCategories: aCollectionOfCategories [
	"An estimate in which all categories appear, even if nothing is attributed to them"

	^ self new
		addCategories: aCollectionOfCategories;
		yourself
]

{ #category : #adding }
GtMemorySpaceEstimate >> addBytes: aNumberOfBytes objectsCount: aNumberOfObjects toCategory: aCategory [
	(self categoryEstimateAt: aCategory)
		addBytes: aNumberOfBytes
		objectsCount: aNumberOfObjects.
	totalBytes := totalBytes + aNumberOfBytes.
	totalObjectsCount := totalObjectsCount + aNumberOfObjects
]

{ #category : #adding }
GtMemorySpaceEstimate >> addBytes: aNumberOfBytes ofTag: aTagName toCategory: aCategory [
	(self categoryEstimateAt: aCategory) addBytes: aNumberOfBytes ofTag: aTagName
]

{ #category : #adding }
GtMemorySpaceEstimate >> addCategories: aCollectionOfCategories [
	"Make the categories appear in the estimate, even if nothing is attributed to them"

	aCollectionOfCategories do: [ :aCategory | self categoryEstimateAt: aCategory ]
]

{ #category : #adding }
GtMemorySpaceEstimate >> addEstimate: anEstimate [
	"Add the bytes, objects and tags of anEstimate to mine, category by category, and its root estimates"

	anEstimate categoryEstimates
		do: [ :each | 
			self
				addBytes: each bytes
				objectsCount: each objectsCount
				toCategory: each category.
			each tagNames
				do: [ :aTagName | 
					self
						addBytes: (each bytesOfTag: aTagName)
						ofTag: aTagName
						toCategory: each category ] ].
	anEstimate rootEstimates do: [ :each | self addRootEstimate: each ]
]

{ #category : #adding }
GtMemorySpaceEstimate >> addRootEstimate: aRootEstimate [
	"Record the memory added by one root"

	rootEstimates ifNil: [ rootEstimates := OrderedCollection new ].
	rootEstimates add: aRootEstimate
]

{ #category : #accessing }
GtMemorySpaceEstimate >> bytesOf: aCategory [
	"The memory attributed to the category"

	^ (self categoryEstimateFor: aCategory)
		ifNil: [ 0 ]
		ifNotNil: [ :aCategoryEstimate | aCategoryEstimate bytes ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> bytesOf: aCategory tag: aTagName [
	"The memory of the objects with the tag among the objects attributed to the category"

	^ (self categoryEstimateFor: aCategory)
		ifNil: [ 0 ]
		ifNotNil: [ :aCategoryEstimate | aCategoryEstimate bytesOfTag: aTagName ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> bytesOfTag: aTagName [
	"The memory of the objects with the tag, over all categories"

	^ self categoryEstimates
		inject: 0
		into: [ :sum :each | sum + (each bytesOfTag: aTagName) ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> categories [
	"The categories, in the order in which they were added"

	^ categoryEstimates keys
]

{ #category : #private }
GtMemorySpaceEstimate >> categoryEstimateAt: aCategory [
	"The estimate of aCategory, created when the category is first used.
	We avoid #at:ifAbsentPut: here, as it would create a block for every addition."

	^ (categoryEstimates at: aCategory ifAbsent: nil)
		ifNil: [ categoryEstimates
				at: aCategory
				put: (GtMemorySpaceCategoryEstimate forCategory: aCategory) ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> categoryEstimateFor: aCategory [
	"The estimate of aCategory, or nil"

	^ categoryEstimates at: aCategory ifAbsent: [ nil ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> categoryEstimates [
	"The estimates of the categories (GtMemorySpaceCategoryEstimate), in the order in which they were added"

	^ categoryEstimates values
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimate >> gtViewCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Categories';
		priority: 10;
		items: [ self sortedCategoryEstimates ];
		column: 'Category'
			text: [ :each | each name ]
			width: 200;
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Percentage'
			text: [ :each | (each bytes * 100 / (self totalBytes max: 1)) rounded asString , '%' ]
			width: 80;
		column: 'Objects'
			text: [ :each | each objectsCount ]
			width: 80;
		column: 'Description' text: [ :each | each description ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimate >> gtViewRootGroupsFor: aView [
	<gtView>
	self rootEstimates ifEmpty: [ ^ aView empty ].

	^ aView columnedList
		title: 'Root groups';
		priority: 5;
		items: [ self rootGroupEstimates ];
		column: 'Group' text: [ :each | each label ];
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Percentage'
			text: [ :each | (each bytes * 100 / (self totalBytes max: 1)) rounded asString , '%' ]
			width: 80;
		column: 'Objects'
			text: [ :each | each objectsCount ]
			width: 80;
		column: 'Roots'
			text: [ :each | each rootEstimates size ]
			width: 60
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimate >> gtViewRootsFor: aView [
	<gtView>
	self rootEstimates ifEmpty: [ ^ aView empty ].

	^ aView columnedList
		title: 'Roots';
		priority: 30;
		items: [ self sortedRootEstimates ];
		column: 'Root' text: [ :each | each label ];
		column: 'Group'
			text: [ :each | each group label ]
			width: 150;
		column: 'Category'
			text: [ :each | each categoryName ]
			width: 180;
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Objects'
			text: [ :each | each objectsCount ]
			width: 80;
		send: [ :each | each root object ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceEstimate >> gtViewTagsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tags';
		priority: 20;
		items: [ self sortedTagEstimates ];
		column: 'Tag'
			text: [ :each | each tagName ]
			width: 120;
		column: 'Size'
			text: [ :each | each bytes humanReadableIsqByteSize ]
			width: 90;
		column: 'Percentage of the total'
			text: [ :each | (each bytes * 100 / (self totalBytes max: 1)) rounded asString , '%' ]
			width: 150;
		column: 'Categories' text: [ :each | each categories size ]
]

{ #category : #initialization }
GtMemorySpaceEstimate >> initialize [
	super initialize.
	categoryEstimates := OrderedDictionary new.
	totalBytes := 0.
	totalObjectsCount := 0
]

{ #category : #accessing }
GtMemorySpaceEstimate >> objectsCountOf: aCategory [
	"The number of objects attributed to the category"

	^ (self categoryEstimateFor: aCategory)
		ifNil: [ 0 ]
		ifNotNil: [ :aCategoryEstimate | aCategoryEstimate objectsCount ]
]

{ #category : #printing }
GtMemorySpaceEstimate >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self totalBytes humanReadableIsqByteSize;
		nextPutAll: ', ';
		print: self totalObjectsCount;
		nextPutAll: ' objects)'
]

{ #category : #accessing }
GtMemorySpaceEstimate >> rootEstimates [
	"The memory added by each root, when the definition records it (GtMemorySpaceRootEstimate)"

	^ rootEstimates ifNil: [ #() ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> rootGroupEstimates [
	"The memory added by each group of roots (GtMemorySpaceRootGroupEstimate), in the order of the groups.
	Computed on each request from the root estimates."

	| groups rootEstimatesOfGroups |
	groups := OrderedCollection new.
	rootEstimatesOfGroups := IdentityDictionary new.
	self rootEstimates
		do: [ :each | 
			(rootEstimatesOfGroups includesKey: each group)
				ifFalse: [ groups add: each group.
					rootEstimatesOfGroups at: each group put: OrderedCollection new ].
			(rootEstimatesOfGroups at: each group) add: each ].
	^ groups asArray
		collect: [ :aGroup | 
			GtMemorySpaceRootGroupEstimate
				group: aGroup
				rootEstimates: (rootEstimatesOfGroups at: aGroup) ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> sortedCategoryEstimates [
	"The estimates of the categories, largest first"

	^ self categoryEstimates asArray sort: [ :a :b | a bytes > b bytes ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> sortedRootEstimates [
	^ self rootEstimates asArray sort: [ :a :b | a bytes > b bytes ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> sortedTagEstimates [
	"The estimates of the tags, largest first"

	^ self tagEstimates asArray sort: [ :a :b | a bytes > b bytes ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> tagEstimateFor: aTagName [
	"The estimate of the tag, or nil"

	^ self tagEstimates detect: [ :each | each tagName = aTagName ] ifNone: [ nil ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> tagEstimates [
	"The estimates of the tags (GtMemorySpaceTagEstimate), in the order in which the tags appear.
	They are computed on each request from the estimates of the tags within categories, 
	which they share with the category estimates."

	| tagEstimates |
	tagEstimates := OrderedDictionary new.
	self categoryEstimates
		do: [ :aCategoryEstimate | 
			aCategoryEstimate tagEstimates
				do: [ :aCategoryTagEstimate | 
					(tagEstimates
						at: aCategoryTagEstimate tagName
						ifAbsentPut: [ GtMemorySpaceTagEstimate named: aCategoryTagEstimate tagName ])
						addCategoryTagEstimate: aCategoryTagEstimate ] ].
	^ tagEstimates values
]

{ #category : #accessing }
GtMemorySpaceEstimate >> tags [
	"The names of the tags of the objects counted"

	^ self tagEstimates collect: [ :each | each tagName ]
]

{ #category : #accessing }
GtMemorySpaceEstimate >> totalBytes [
	"Kept up to date while adding, as definitions ask for it after every root"

	^ totalBytes
]

{ #category : #accessing }
GtMemorySpaceEstimate >> totalObjectsCount [
	^ totalObjectsCount
]
