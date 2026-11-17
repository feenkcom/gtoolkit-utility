"
I hold an object, in examples of {{gtClass:GtMemorySpaceRetention}}. I am used only by examples, so that all my instances are known.
"
Class {
	#name : #GtMemorySpaceRetentionExampleHolder,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceRetentionExampleHolder >> contents [
	^ contents
]

{ #category : #accessing }
GtMemorySpaceRetentionExampleHolder >> contents: anObject [
	contents := anObject
]
