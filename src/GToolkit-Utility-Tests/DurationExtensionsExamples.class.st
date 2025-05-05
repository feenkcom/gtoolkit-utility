Class {
	#name : #DurationExtensionsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #examples }
DurationExtensionsExamples >> hours [
	<gtExample>
	<return: #DurationExtensionsExamples>
	self assert: 1 hour gtShortPrintString equals: '01:00:00s'.
	self assert: 12 hours gtShortPrintString equals: '12:00:00s'
]

{ #category : #examples }
DurationExtensionsExamples >> milliseconds [
	<gtExample>
	<return: #DurationExtensionsExamples>
	self assert: 1 milliSecond gtShortPrintString equals: '0.001s'.
	self assert: 12 milliSeconds gtShortPrintString equals: '0.012s'.
	self assert: 123 milliSeconds gtShortPrintString equals: '0.123s'
]

{ #category : #examples }
DurationExtensionsExamples >> minutes [
	<gtExample>
	<return: #DurationExtensionsExamples>
	self assert: 1 minute gtShortPrintString equals: '01:00s'.
	self assert: 12 minutes gtShortPrintString equals: '12:00s'
]

{ #category : #examples }
DurationExtensionsExamples >> seconds [
	<gtExample>
	<return: #DurationExtensionsExamples>
	self assert: 1 second gtShortPrintString equals: '1s'.
	self assert: 12 seconds gtShortPrintString equals: '12s'
]
