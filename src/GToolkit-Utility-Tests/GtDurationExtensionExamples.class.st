"
Examples for Duration>>#closeTo:.
"
Class {
	#name : #GtDurationExtensionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #examples }
GtDurationExtensionExamples >> differentDurationsAreNotClose [
	<gtExample>
	| duration |
	duration := Duration seconds: 1.
	self assert: (duration closeTo: (Duration seconds: 2)) equals: false.
	^ duration
]

{ #category : #examples }
GtDurationExtensionExamples >> equalDurationsAreClose [
	<gtExample>
	| duration |
	duration := Duration seconds: 1.
	self assert: (duration closeTo: (Duration seconds: 1)).
	^ duration
]
