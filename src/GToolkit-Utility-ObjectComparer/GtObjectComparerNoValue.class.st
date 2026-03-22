"
I represent the absence of a slot value for an object in a comparison.
"
Class {
	#name : #GtObjectComparerNoValue,
	#superclass : #GtObjectComparerValue,
	#category : #'GToolkit-Utility-ObjectComparer-Core'
}

{ #category : #printing }
GtObjectComparerNoValue >> gtDisplayOn: aStream [
	^ aStream nextPutAll: '—'
]

{ #category : #testing }
GtObjectComparerNoValue >> hasValue [
	^ false
]
