"
I hold the bytes of the objects with one tag within one category of a {{gtClass:GtMemorySpaceEstimate}}, for example the strings in the text of snippets.

I am shared by the estimate of my category ({{gtClass:GtMemorySpaceCategoryEstimate}}) and the estimate of my tag ({{gtClass:GtMemorySpaceTagEstimate}}).
"
Class {
	#name : #GtMemorySpaceCategoryTagEstimate,
	#superclass : #Object,
	#instVars : [
		'category',
		'tagName',
		'bytes'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceCategoryTagEstimate class >> category: aCategory tagName: aTagName [
	^ self new
		category: aCategory;
		tagName: aTagName;
		yourself
]

{ #category : #adding }
GtMemorySpaceCategoryTagEstimate >> addBytes: aNumberOfBytes [
	bytes := bytes + aNumberOfBytes
]

{ #category : #accessing }
GtMemorySpaceCategoryTagEstimate >> bytes [
	"The memory of the objects with the tag within the category"

	^ bytes
]

{ #category : #accessing }
GtMemorySpaceCategoryTagEstimate >> category [
	^ category
]

{ #category : #accessing }
GtMemorySpaceCategoryTagEstimate >> category: aCategory [
	category := aCategory
]

{ #category : #initialization }
GtMemorySpaceCategoryTagEstimate >> initialize [
	super initialize.
	bytes := 0
]

{ #category : #printing }
GtMemorySpaceCategoryTagEstimate >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: tagName;
		nextPutAll: ' in ';
		nextPutAll: (GtMemorySpaceCategory nameOf: category);
		nextPutAll: ': ';
		nextPutAll: bytes humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceCategoryTagEstimate >> tagName [
	^ tagName
]

{ #category : #accessing }
GtMemorySpaceCategoryTagEstimate >> tagName: aTagName [
	tagName := aTagName
]
