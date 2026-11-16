Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Utility-Basic' }
OrderedDictionary >> selectEvaluatingInAnyOrder: aBlock [
	"Like #select:, the result keeps my key order, but aBlock is evaluated in no particular order.
	I only walk my ordered keys when at least two values are selected, so I am much faster
	than #select: when few values are selected."
	| selected selectedKeys newDictionary |
	selected := self unorderedSelect: aBlock.
	selected size < 2 ifTrue: [^selected].
	selectedKeys := IdentitySet new: selected size.
	selected keysDo: [:each | selectedKeys add: each].
	newDictionary := self species new: selected size.
	self keysDo: 
			[:each |
			(selectedKeys includes: each)
				ifTrue: [newDictionary at: each put: (selected at: each)]].
	self assert: [newDictionary size = selected size]
		description: 
			['The ordered keys and the dictionary must hold identical key objects'].
	^newDictionary
]

{ #category : #'*GToolkit-Utility-Basic' }
OrderedDictionary >> unorderedSelect: aBlock [
	"Like #select:, but aBlock is evaluated in no particular order and the order of the result is unspecified.
	I do not look up every key, so I am much faster than #select: on large dictionaries."
	| newDictionary |
	newDictionary := self copyEmpty.
	dictionary associationsDo: 
			[:each |
			(aBlock value: each value)
				ifTrue: [newDictionary at: each key put: each value]].
	^newDictionary
]
