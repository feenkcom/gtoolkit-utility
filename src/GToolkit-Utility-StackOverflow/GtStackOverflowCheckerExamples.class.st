Class {
	#name : #GtStackOverflowCheckerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-StackOverflow'
}

{ #category : #private }
GtStackOverflowCheckerExamples >> recurseUntil: aBlock [
	aBlock value ifTrue: [^self].
	^self recurseUntil: aBlock
]

{ #category : #running }
GtStackOverflowCheckerExamples >> testStackOverflow [
	<gtExample>

	GtStackOverflowChecker suspendStackOverflowWatchersDuring: 
			[| end overflowed |
			overflowed := false.
			GtStackOverflowChecker startStackOverflowWatcher.
			end := DateAndTime now + 2 seconds.
			[self recurseUntil: [DateAndTime now > end]] 
				on: GtStackOverflowError
				do: [overflowed := true].
			self assert: overflowed]
]

{ #category : #running }
GtStackOverflowCheckerExamples >> testStackOverflowDisabled [
	<gtExample>

	GtStackOverflowChecker suspendStackOverflowWatchersDuring: 
			[| end overflowed |
			overflowed := false.
			end := DateAndTime now + 2 seconds.
			[self recurseUntil: [DateAndTime now > end]] 
				on: GtStackOverflowError
				do: [ overflowed := true ].
			self assert: overflowed not ]
]
