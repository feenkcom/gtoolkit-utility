"
I provide executable examples for GtObjectComparer.
"
Class {
	#name : #GtObjectComparerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ObjectComparer-Examples'
}

{ #category : #examples }
GtObjectComparerExamples >> differentClasses [
	<gtExample>
	<return: #GtObjectComparer>
	| comparer xDiff yDiff |
	comparer := GtObjectComparer
			compareAll: {Point x: 1 y: 2.
					42.
					3 @ 2}.
	self assert: comparer hasDifferences.
	xDiff := comparer childComparers detect: [ :each | each label = #x ].
	yDiff := comparer childComparers detect: [ :each | each label = #y ].
	self assert: (xDiff values at: 1) class equals: GtObjectComparerSlotValue.
	self assert: (xDiff values at: 2) class equals: GtObjectComparerNoValue.
	self assert: (xDiff values at: 3) class equals: GtObjectComparerSlotValue.
	self assert: (yDiff values at: 1) class equals: GtObjectComparerSlotValue.
	self assert: (yDiff values at: 2) class equals: GtObjectComparerNoValue.
	self assert: (yDiff values at: 3) class equals: GtObjectComparerSlotValue.
	^ comparer
]

{ #category : #examples }
GtObjectComparerExamples >> differentLayouts [
	<gtExample>
	<return: #GtObjectComparer>
	| comparer layoutDiff |
	comparer := GtObjectComparer
			compareAll: {BlElement new.
					BlElement new layout: BlLinearLayout new}.
	layoutDiff := comparer childComparers detect: [ :each | each label = #layout ].
	self assert: layoutDiff hasDifferences.
	self assert: layoutDiff childComparers isNotEmpty.
	^ comparer
]

{ #category : #examples }
GtObjectComparerExamples >> differentManyPoints [
	<gtExample>
	<return: #GtObjectComparer>
	| comparer xDiff yDiff |
	comparer := GtObjectComparer
			compareAll: {Point x: 1 y: 2.
					Point x: 3 y: 2.
					Point x: 3 y: 4}.
	self assert: comparer hasDifferences.
	xDiff := comparer childComparers detect: [ :each | each label = #x ].
	yDiff := comparer childComparers detect: [ :each | each label = #y ].
	self
		assert: (xDiff values collect: [ :each | each value ]) asArray
		equals: #(1 3 3).
	self
		assert: (yDiff values collect: [ :each | each value ]) asArray
		equals: #(2 2 4).
	self assert: xDiff hasDifferences.
	self assert: yDiff hasDifferences.
	^ comparer
]

{ #category : #examples }
GtObjectComparerExamples >> differentPoints [
	<gtExample>
	<return: #GtObjectComparer>
	| comparer xDiff |
	comparer := GtObjectComparer
			compareAll: {Point x: 1 y: 2.
					Point x: 3 y: 2}.
	self assert: comparer hasDifferences.
	xDiff := comparer childComparers detect: [ :each | each label = #x ].
	self
		assert: (xDiff values collect: [ :each | each value ]) asArray = #(1 3).
	self assert: xDiff hasDifferences.
	^ comparer
]

{ #category : #examples }
GtObjectComparerExamples >> equalPoints [
	<gtExample>
	<return: #GtObjectComparer>
	| comparer xDiff |
	comparer := GtObjectComparer
			compareAll: {Point x: 1 y: 2.
					Point x: 1 y: 2}.
	self assert: comparer hasDifferences not.
	xDiff := comparer childComparers detect: [ :each | each label = #x ].
	self assert: xDiff hasDifferences not.
	^ comparer
]
