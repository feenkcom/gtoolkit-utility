Class {
	#name : #GtObjectComparerObjectValue,
	#superclass : #GtObjectComparerValue,
	#category : #'GToolkit-Utility-ObjectComparer-Core'
}

{ #category : #printing }
GtObjectComparerObjectValue >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Value: '.
	self value gtDisplayOn: aStream.
	aStream space.
	aStream nextPutAll: 'Object: '.
	self object gtDisplayOn: aStream
]

{ #category : #testing }
GtObjectComparerObjectValue >> hasValue [
	^ true
]

{ #category : #accessing }
GtObjectComparerObjectValue >> value [
	^ object
]
