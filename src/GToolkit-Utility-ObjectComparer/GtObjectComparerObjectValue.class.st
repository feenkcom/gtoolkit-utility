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

{ #category : #'as yet unclassified' }
GtObjectComparerObjectValue >> textForValue [
	^ self valueDisplayString asRopedText glamorousRegularFont
		, String space asRopedText glamorousRegularFont glamorousRegularSmallSize
		, (self value class name asRopedText glamorousRegularFont
				glamorousRegularSmallSize foreground: Color veryLightGray)
]

{ #category : #accessing }
GtObjectComparerObjectValue >> value [
	^ object
]

{ #category : #printing }
GtObjectComparerObjectValue >> valueDisplayOn: aStream [
	self value gtDisplayOn: aStream
]
