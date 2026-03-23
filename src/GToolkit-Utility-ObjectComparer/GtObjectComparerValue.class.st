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

{ #category : #'as yet unclassified' }
GtObjectComparerValue >> valueDisplayOn: s [ 
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtObjectComparerValue >> valueDisplayString [
	^ String streamContents: [:s | self valueDisplayOn: s ]
]
