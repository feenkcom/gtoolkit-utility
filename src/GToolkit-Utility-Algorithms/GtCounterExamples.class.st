Class {
	#name : #GtCounterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Algorithms-Counter - Examples'
}

{ #category : #accessing }
GtCounterExamples >> gtLetterCounts [
	<gtExample>
	<return: #GtCounter>
	| counter |
	counter := GtCounter new.

	String loremIpsum do: [ :aCharacter | counter increment: aCharacter ].

	self assert: counter mostFrequent equals: Character space.
	self assert: counter size equals: 28.
	self assert: counter keys size equals: 28.

	^ counter
]
