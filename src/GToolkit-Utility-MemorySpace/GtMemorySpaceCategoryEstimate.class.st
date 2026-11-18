"
I hold the estimated memory of one category in a {{gtClass:GtMemorySpaceEstimate}}: the number of bytes and of objects attributed to the category, and, for the tagged objects among them (see {{gtClass:GtMemorySpaceTag}}), one {{gtClass:GtMemorySpaceCategoryTagEstimate}} per tag.
"
Class {
	#name : #GtMemorySpaceCategoryEstimate,
	#superclass : #Object,
	#instVars : [
		'category',
		'bytes',
		'objectsCount',
		'tagEstimates'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceCategoryEstimate class >> forCategory: aCategory [
	^ self new
		category: aCategory;
		yourself
]

{ #category : #adding }
GtMemorySpaceCategoryEstimate >> addBytes: aNumberOfBytes objectsCount: aNumberOfObjects [
	bytes := bytes + aNumberOfBytes.
	objectsCount := objectsCount + aNumberOfObjects
]

{ #category : #adding }
GtMemorySpaceCategoryEstimate >> addBytes: aNumberOfBytes ofTag: aTagName [
	(self tagEstimateAt: aTagName) addBytes: aNumberOfBytes
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> bytes [
	"The memory attributed to the category"

	^ bytes
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> bytesOfTag: aTagName [
	"The memory of the objects with this tag among the objects attributed to the category"

	^ (self tagEstimateFor: aTagName)
		ifNil: [ 0 ]
		ifNotNil: [ :aTagEstimate | aTagEstimate bytes ]
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> category [
	^ category
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> category: aCategory [
	category := aCategory
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> description [
	^ (category isKindOf: GtMemorySpaceCategory)
		ifTrue: [ category description ]
		ifFalse: [ '' ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceCategoryEstimate >> gtViewDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ {{'Category'.
					self name.
					category}.
				{'Size'.
					bytes humanReadableIsqByteSize.
					bytes}.
				{'Objects'.
					objectsCount printString.
					objectsCount}.
				{'Description'.
					self description.
					self description}}
				, (self tagEstimates
						collect: [ :aTagEstimate | 
							{'Tag ' , aTagEstimate tagName printString.
								aTagEstimate bytes humanReadableIsqByteSize.
								aTagEstimate} ]) ];
		column: 'Property'
			text: [ :each | each first ]
			width: 120;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #initialization }
GtMemorySpaceCategoryEstimate >> initialize [
	super initialize.
	bytes := 0.
	objectsCount := 0
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> name [
	^ GtMemorySpaceCategory nameOf: category
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> objectsCount [
	"The number of objects attributed to the category"

	^ objectsCount
]

{ #category : #printing }
GtMemorySpaceCategoryEstimate >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPutAll: ': ';
		nextPutAll: bytes humanReadableIsqByteSize;
		nextPutAll: ', ';
		print: objectsCount;
		nextPutAll: ' objects)'
]

{ #category : #private }
GtMemorySpaceCategoryEstimate >> tagEstimateAt: aTagName [
	"The estimate of the tag within the category, created when the tag is first used"

	tagEstimates ifNil: [ tagEstimates := OrderedDictionary new ].
	^ (tagEstimates at: aTagName ifAbsent: nil)
		ifNil: [ tagEstimates
				at: aTagName
				put: (GtMemorySpaceCategoryTagEstimate category: category tagName: aTagName) ]
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> tagEstimateFor: aTagName [
	"The estimate of the tag within the category, or nil"

	^ tagEstimates ifNotNil: [ tagEstimates at: aTagName ifAbsent: [ nil ] ]
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> tagEstimates [
	"The estimates of the tags within the category (GtMemorySpaceCategoryTagEstimate)"

	^ tagEstimates ifNil: [ #() ] ifNotNil: [ tagEstimates values ]
]

{ #category : #accessing }
GtMemorySpaceCategoryEstimate >> tagNames [
	^ tagEstimates ifNil: [ #() ] ifNotNil: [ tagEstimates keys ]
]
