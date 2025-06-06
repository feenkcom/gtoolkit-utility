Class {
	#name : #GtRBNodeQueryExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-RB'
}

{ #category : #accessing }
GtRBNodeQueryExamples >> blocksFromArgs [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self exampleMethod // 'variable' \ 'block'.
	self assert: result size equals: 1.
	^ result
]

{ #category : #accessing }
GtRBNodeQueryExamples >> blocksWithoutArgs [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self exampleMethod // 'block'
			select: [ :each | each arguments isEmpty ].
	self assert: result size equals: 1.
	^ result
]

{ #category : #accessing }
GtRBNodeQueryExamples >> exampleMethod [
	<gtExample>
	<return: #RBMethodNode>
	^ RBParser
		parseMethod: 'test
	| var1 var2 |
	var1 := #(printString ''string'' 1 #[0] #() 1.0 true false).
	var2 := var1 select: #isString.
	^[(var2 select: [:each | each isString])  size] value'
]

{ #category : #accessing }
GtRBNodeQueryExamples >> literalParentLiterals [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self literals \ 'literal'.
	self assert: result size equals: 2.
	^ result
]

{ #category : #accessing }
GtRBNodeQueryExamples >> literals [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self exampleMethod // 'literal'.
	self assert: result size equals: 11.
	^ result
]

{ #category : #accessing }
GtRBNodeQueryExamples >> literalsInLiterals [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self literals // 'literal'.
	self assert: result size equals: 9.
	^ result
]

{ #category : #accessing }
GtRBNodeQueryExamples >> sequenceNodeParent [
	<gtExample>
	<return: #GtRBNodeQuery>
	| result |
	result := self literals \\ 'sequence'.
	self assert: result size equals: 1.
	^ result
]
