"
I attribute an object, and all objects reachable from it that were not counted before, to one category.
"
Class {
	#name : #GtMemorySpaceCategoryAttribution,
	#superclass : #GtMemorySpaceAttribution,
	#instVars : [
		'category'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceCategoryAttribution >> categoriesDo: aBlock [
	aBlock value: category
]

{ #category : #accessing }
GtMemorySpaceCategoryAttribution >> category [
	^ category
]

{ #category : #accessing }
GtMemorySpaceCategoryAttribution >> category: aCategory [
	category := aCategory
]

{ #category : #estimating }
GtMemorySpaceCategoryAttribution >> estimate: anObject with: anEstimator into: anEstimate [
	anEstimator
		estimate: anObject
		inCategory: category
		into: anEstimate
]

{ #category : #accessing }
GtMemorySpaceCategoryAttribution >> summary [
	^ GtMemorySpaceCategory nameOf: category
]
