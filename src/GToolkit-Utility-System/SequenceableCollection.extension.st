Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Utility-System' }
SequenceableCollection >> gtHasEqualElements: otherCollection by: aComparatorBlock [
	"Answer whether the receiver's size is the same as otherCollection's
	size, and each of the receiver's elements is equal to the corresponding 
	element of otherCollection when compared using a given comparator block"

	| size |
	(otherCollection isKindOf: SequenceableCollection) ifFalse: [^ false].
	(size := self size) = otherCollection size ifFalse: [^ false].
	1 to: size do:
		[:index |
		(aComparatorBlock value: (self at: index) value: (otherCollection at: index)) ifFalse: [^ false]].
	^ true
]

{ #category : #'*GToolkit-Utility-System' }
SequenceableCollection >> gtHasIdenticalElements: otherCollection [
	"Answer whether the receiver's size is the same as otherCollection's
	size, and each of the receiver's elements is identical (==) the corresponding 
	element of otherCollection."

	^ self gtHasEqualElements: otherCollection by: [ :a :b | a == b ]
]
