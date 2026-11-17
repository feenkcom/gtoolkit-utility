Class {
	#name : #GtOrderedDictionaryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #examples }
GtOrderedDictionaryExamples >> dictionaryWithScrambledKeys [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary |
	aDictionary := OrderedDictionary new.
	#(17 3 20 8 11 1 14 6 19 2 9 15 4 12 18 7 13 5 16 10)
		do: [:each | aDictionary at: each put: each * 10].
	self assert: aDictionary size equals: 20.
	self assert: aDictionary keys
		equals: #(17 3 20 8 11 1 14 6 19 2 9 15 4 12 18 7 13 5 16 10).
	^aDictionary
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderEvaluatesEachValueOnce [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary theEvaluatedValues aResult |
	aDictionary := self dictionaryWithScrambledKeys.
	theEvaluatedValues := OrderedCollection new.
	aResult := aDictionary selectEvaluatingInAnyOrder: 
					[:each |
					theEvaluatedValues add: each.
					each > 100].
	self assert: theEvaluatedValues size equals: aDictionary size.
	self assert: theEvaluatedValues asSet equals: aDictionary values asSet.
	self assert: aResult keys equals: #(17 20 11 14 19 15 12 18 13 16).
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderKeepsTheKeyOrder [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary aResult |
	aDictionary := self dictionaryWithScrambledKeys.
	aResult := aDictionary
				selectEvaluatingInAnyOrder: [:each | each \\ 20 = 0].
	self assert: aResult class equals: OrderedDictionary.
	self assert: aResult keys equals: #(20 8 14 6 2 4 12 18 16 10).
	self assert: aResult keys
		equals: (aDictionary select: [:each | each \\ 20 = 0]) keys.
	aResult
		keysAndValuesDo: [:aKey :aValue | self assert: aValue equals: aKey * 10].
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderKeepsTheSpecies [
	<gtExample>
	<return: #OrderedIdentityDictionary>
	| aDictionary aResult |
	aDictionary := OrderedIdentityDictionary new.
	#(#delta #alpha #echo #charlie #bravo)
		withIndexDo: [:aKey :anIndex | aDictionary at: aKey put: anIndex].
	aResult := aDictionary selectEvaluatingInAnyOrder: [:each | each odd].
	self assert: aResult class equals: OrderedIdentityDictionary.
	self assert: aResult keys equals: #(#delta #echo #bravo).
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderWithOneMatch [
	<gtExample>
	<return: #OrderedDictionary>
	| aResult |
	aResult := self dictionaryWithScrambledKeys
				selectEvaluatingInAnyOrder: [:each | each = 150].
	self assert: aResult keys equals: #(15).
	self assert: (aResult at: 15) equals: 150.
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderWithUuidKeys [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary aResult |
	aDictionary := OrderedDictionary new.
	1 to: 50 do: [:each | aDictionary at: UUID new put: each].
	aResult := aDictionary selectEvaluatingInAnyOrder: [:each | each \\ 3 = 0].
	self assert: aResult size equals: 16.
	self assert: aResult values asArray equals: (3 to: 48 by: 3) asArray.
	self assert: aResult keys
		equals: (aDictionary select: [:each | each \\ 3 = 0]) keys.
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> selectEvaluatingInAnyOrderWithoutMatchesIsEmpty [
	<gtExample>
	<return: #OrderedDictionary>
	| aResult |
	aResult := self dictionaryWithScrambledKeys
				selectEvaluatingInAnyOrder: [:each | false].
	self assert: aResult class equals: OrderedDictionary.
	self assert: aResult isEmpty.
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> unorderedSelectAnswersTheSelectedAssociations [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary aResult |
	aDictionary := self dictionaryWithScrambledKeys.
	aResult := aDictionary unorderedSelect: [:each | each \\ 20 = 0].
	self assert: aResult class equals: OrderedDictionary.
	self assert: aResult size equals: 10.
	self assert: aResult keys asSet
		equals: (aDictionary keys select: [:each | each even]) asSet.
	aResult
		keysAndValuesDo: [:aKey :aValue | self assert: aValue equals: aKey * 10].
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> unorderedSelectCopiesTheAssociations [
	<gtExample>
	<return: #OrderedDictionary>
	| aDictionary aResult |
	aDictionary := self dictionaryWithScrambledKeys.
	aResult := aDictionary unorderedSelect: [:each | true].
	self assert: aResult size equals: aDictionary size.
	aResult keysDo: 
			[:aKey |
			self
				assert: ((aResult associationAt: aKey) == (aDictionary associationAt: aKey))
						not].
	^aResult
]

{ #category : #examples }
GtOrderedDictionaryExamples >> unorderedSelectWithoutMatchesIsEmpty [
	<gtExample>
	<return: #OrderedDictionary>
	| aResult |
	aResult := self dictionaryWithScrambledKeys
				unorderedSelect: [:each | false].
	self assert: aResult class equals: OrderedDictionary.
	self assert: aResult isEmpty.
	^aResult
]
