Class {
	#name : #GtStackOverflowEnabledExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-StackOverflow'
}

{ #category : #accessing }
GtStackOverflowEnabledExamples >> testRecurse [
	<gtExample>
	<noTest>
	| caught block |

	caught := false.
	block := [ :x | x < 0
		ifTrue: [ 2 seconds wait. 'Done' ]
		ifFalse: [ block value: x - 1 ] ].
	[ block value: 10000 ]
		on: GtStackOverflowError
		do: [ :ex | caught := true ].
	self assert: caught.
	^ caught
]
