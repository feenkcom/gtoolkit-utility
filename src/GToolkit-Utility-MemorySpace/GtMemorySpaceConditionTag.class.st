"
I tag the instances of the classes for which my condition, a block taking a class, answers true. The condition is evaluated once per class.
"
Class {
	#name : #GtMemorySpaceConditionTag,
	#superclass : #GtMemorySpaceTag,
	#instVars : [
		'condition'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceConditionTag >> condition [
	^ condition
]

{ #category : #accessing }
GtMemorySpaceConditionTag >> condition: aBlock [
	condition := aBlock
]

{ #category : #accessing }
GtMemorySpaceConditionTag >> description [
	"The source of the condition, on one line"

	^ ' ' join: condition printString substrings
]

{ #category : #testing }
GtMemorySpaceConditionTag >> matchesClass: aClass [
	^ condition value: aClass
]
