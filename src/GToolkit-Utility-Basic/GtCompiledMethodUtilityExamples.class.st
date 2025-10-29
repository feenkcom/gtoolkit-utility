Class {
	#name : #GtCompiledMethodUtilityExamples,
	#superclass : #Object,
	#instVars : [
		'slotForTesting'
	],
	#category : #'GToolkit-Utility-Basic-Examples'
}

{ #category : #'as yet unclassified' }
GtCompiledMethodUtilityExamples >> methodAccessedSlots [
	<gtExample>
	self
		assert: (Message >> #setSelector:arguments:) gtAccessedSlots size
		equals: 2.
	self
		assert: (Message>>#arguments) gtAccessedSlots size
		equals: 1
]

{ #category : #'as yet unclassified' }
GtCompiledMethodUtilityExamples >> methodIsGetter [
	<gtExample>
	self assert:  (GtCompiledMethodUtilityExamples>>#slotForTesting) gtIsGetter.
	self assert: (GtCompiledMethodUtilityExamples>>#slotForTesting:) gtIsGetter not
]

{ #category : #'as yet unclassified' }
GtCompiledMethodUtilityExamples >> methodIsSetter [
	<gtExample>
	self assert: (GtCompiledMethodUtilityExamples>>#slotForTesting:) gtIsSetter.
	self assert:  (GtCompiledMethodUtilityExamples>>#slotForTesting) gtIsSetter not
]

{ #category : #'as yet unclassified' }
GtCompiledMethodUtilityExamples >> methodSelfMethods [
	<gtExample>
	self
		assert: (CompiledMethod >> #gtSelfMethods) gtSelfMethods
				= {CompiledMethod >> #selfMessages.
						CompiledMethod >> #methodClass} asSet
]

{ #category : #'as yet unclassified' }
GtCompiledMethodUtilityExamples >> methodSuperMethods [
	<gtExample>
	self
		assert: (CompiledMethod>>#=) gtSuperMethods
				equals: {CompiledCode>>#=} asSet
]

{ #category : #accessing }
GtCompiledMethodUtilityExamples >> slotForTesting [
	^ slotForTesting
]

{ #category : #accessing }
GtCompiledMethodUtilityExamples >> slotForTesting: anObject [
	slotForTesting := anObject
]
