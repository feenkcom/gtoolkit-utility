Class {
	#name : #GtDummyItemGroupExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #'as yet unclassified' }
GtDummyItemGroupExamples >> groupedByCommonValueY [
	<gtExample>
	| grouped |
	grouped := self sourceGroupWithTwoKindsOfItems groupedByCommonValueY.
	self assert: grouped size equals: 1.
	self assert: (grouped anyOne isKindOf: GtDummyItemGroup).
	^ grouped
]

{ #category : #'as yet unclassified' }
GtDummyItemGroupExamples >> groupedByCommonValueZ [
	<gtExample>
	| grouped |
	grouped := self sourceGroupWithTwoKindsOfItems groupedByCommonValueZ.
	self assert: grouped size equals: 2.
	self assert: ((grouped at: 40) isKindOf: GtDummyItemBGroup).
	self assert: ((grouped at: 41) isKindOf: GtDummyItemAGroup).
	^ grouped
]

{ #category : #'as yet unclassified' }
GtDummyItemGroupExamples >> sourceGroupWithTwoKindsOfItems [
	<gtExample>
	| group |
	group := GtDummyItemGroup withAll: {GtDummyGroupBItem
					valueY: 42
					valueZ: 40
					valueB1: 3
					valueB2: 4.
				GtDummyGroupBItem
					valueY: 42
					valueZ: 40
					valueB1: 30
					valueB2: 4.
				GtDummyGroupAItem
					valueY: 42
					valueZ: 41
					valueA: 100}.
	^ group
]
