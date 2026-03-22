"
I represent a value participating in an object comparison.
"
Class {
	#name : #GtObjectComparerValue,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Utility-ObjectComparer-Core'
}

{ #category : #testing }
GtObjectComparerValue >> hasValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtObjectComparerValue >> object [
	^ object
]

{ #category : #accessing }
GtObjectComparerValue >> object: anObject [
	object := anObject
]
