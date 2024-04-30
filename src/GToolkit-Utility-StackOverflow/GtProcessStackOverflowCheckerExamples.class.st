Class {
	#name : #GtProcessStackOverflowCheckerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-StackOverflow'
}

{ #category : #private }
GtProcessStackOverflowCheckerExamples >> recurseUntil: aBlock [
	aBlock value ifTrue: [^self].
	^self recurseUntil: aBlock
]

{ #category : #tests }
GtProcessStackOverflowCheckerExamples >> testStackOverflow [
	<gtExample>

	GtStackOverflowChecker suspendStackOverflowWatchersDuring: 
		[ | end overflowed |
		overflowed := false.
		GtProcessStackOverflowChecker startForProcess: Processor activeProcess.
		end := DateAndTime now + 2 seconds.
		[self recurseUntil: [DateAndTime now > end]] 
			on: GtStackOverflowError
			do: [overflowed := true].
		self assert: overflowed]
]

{ #category : #tests }
GtProcessStackOverflowCheckerExamples >> testStackOverflowDisabled [
	<gtExample>

	GtStackOverflowChecker suspendStackOverflowWatchersDuring: 
			[| end overflowed |
			overflowed := false.
			end := DateAndTime now + 2 seconds.
			[self recurseUntil: [DateAndTime now > end]] 
				on: StackOverflowError
				do: [overflowed := true].
			self assert: overflowed not]
]
