"
I represent an existing slot value for an object in a comparison.
"
Class {
	#name : #GtObjectComparerSlotValue,
	#superclass : #GtObjectComparerValue,
	#instVars : [
		'slotName',
		'value'
	],
	#category : #'GToolkit-Utility-ObjectComparer-Core'
}

{ #category : #printing }
GtObjectComparerSlotValue >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Object: '.
	self object gtDisplayOn: aStream.
	aStream space.
	aStream nextPutAll: 'Slot: '.
	slotName gtDisplayOn: aStream.
	aStream space.
	aStream nextPutAll: 'Value: '.
	self value gtDisplayOn: aStream
]

{ #category : #testing }
GtObjectComparerSlotValue >> hasValue [
	^ true
]

{ #category : #accessing }
GtObjectComparerSlotValue >> slotName: eachSlotName [ 
	slotName := eachSlotName
]

{ #category : #'as yet unclassified' }
GtObjectComparerSlotValue >> textForValue [
	^ self valueDisplayString asRopedText glamorousRegularFont
		, String space asRopedText glamorousRegularFont glamorousRegularSmallSize
		, (self value class name asRopedText glamorousRegularFont
				glamorousRegularSmallSize foreground: Color veryLightGray)
]

{ #category : #accessing }
GtObjectComparerSlotValue >> value [
	^ value
]

{ #category : #accessing }
GtObjectComparerSlotValue >> value: anObject [
	value := anObject
]

{ #category : #printing }
GtObjectComparerSlotValue >> valueDisplayOn: aStream [
	self value gtDisplayOn: aStream
]
