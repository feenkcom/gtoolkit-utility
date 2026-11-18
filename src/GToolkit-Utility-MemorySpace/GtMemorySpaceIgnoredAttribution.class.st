"
I do not count anything. I am used for slots whose objects do not belong to the estimated memory space, like the parent of a node.
"
Class {
	#name : #GtMemorySpaceIgnoredAttribution,
	#superclass : #GtMemorySpaceAttribution,
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceIgnoredAttribution >> categoriesDo: aBlock [
	
]

{ #category : #estimating }
GtMemorySpaceIgnoredAttribution >> estimate: anObject with: anEstimator into: anEstimate [
	"Nothing is counted"

	
]

{ #category : #accessing }
GtMemorySpaceIgnoredAttribution >> summary [
	^ 'not counted'
]
