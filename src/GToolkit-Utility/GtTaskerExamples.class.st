Class {
	#name : #GtTaskerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #basic }
GtTaskerExamples >> basicOrderedNonRepetitiveTasker [
	<gtExample>
	| aCollection aTask |
	aCollection := self emptyOrderedNonRepetitiveTasker.
	aTask := self basicValuableTask.
	aCollection addTask: aTask.
	self assert: aCollection collection anyOne equals: aTask.
	self assert: aCollection size equals: 1.
	aCollection addTask: aTask.
	self assert: aCollection collection anyOne equals: aTask.
	self assert: aCollection size equals: 1.
	^ aCollection
]

{ #category : #basic }
GtTaskerExamples >> basicPostponingTasker [
	<gtExample>
	| aSubTasker aTasker |
	aSubTasker := self basicOrderedNonRepetitiveTasker.
	aTasker := aSubTasker asPostponingTasker.
	self assert: aTasker tasker equals: aSubTasker.
	^ aTasker
]

{ #category : #basic }
GtTaskerExamples >> basicValuableTask [
	<gtExample>
	| aTask aValue aBlock |
	aValue := 0.
	aBlock := [ aValue := aValue + 1 ].
	aTask := self emptyValuableTask.
	aTask valuable: aBlock.
	self assert: aTask valuable equals: aBlock.
	aTask execute.
	self assert: aValue equals: 1.
	^ aTask
]

{ #category : #comparison }
GtTaskerExamples >> compareDifferentValuableTasks [
	<gtExample>
	| aTaskOne aTaskTwo |
	aTaskOne := self basicValuableTask.
	aTaskTwo := self basicValuableTask.
	self assert: aTaskOne ~= aTaskTwo.
	self assert: aTaskOne hash ~= aTaskTwo hash.
	^ Array with: aTaskOne with: aTaskTwo.
]

{ #category : #comparison }
GtTaskerExamples >> compareSameValuableTasks [
	<gtExample>
	| aTaskOne aTaskTwo aBlock |
	aBlock := [ "do nothing" ].
	aTaskOne := self emptyValuableTask valuable: aBlock.
	aTaskTwo := self emptyValuableTask valuable: aBlock.
	self assert: aTaskOne equals: aTaskTwo.
	self assert: aTaskOne hash equals: aTaskTwo hash.
	^ Array with: aTaskOne with: aTaskTwo.
]

{ #category : #empty }
GtTaskerExamples >> emptyOrderedNonRepetitiveTasker [
	<gtExample>
	| aCollection |
	aCollection := GtTasker orderedNonRepetitive.
	self assert: aCollection size equals: 0.
	^ aCollection
]

{ #category : #empty }
GtTaskerExamples >> emptyValuableTask [
	<gtExample>
	| aTask |
	aTask := GtTaskerValuableTask new.
	self assert: aTask valuable isNotNil.
	aTask execute.
	^ aTask
]

{ #category : #basic }
GtTaskerExamples >> keepOrderInOrderedNonRepetitiveTasker [
	<gtExample>
	| aCollection aTaskOne aValue aBlockOne aBlockTwo aTaskTwo aTaskThree |
	aCollection := self emptyOrderedNonRepetitiveTasker.
	aValue := 2.
	aBlockOne := [ aValue := aValue + 3 ].
	aBlockTwo := [ aValue := aValue * 5 ].
	aTaskOne := self emptyValuableTask valuable: aBlockOne.
	aTaskTwo := self emptyValuableTask valuable: aBlockTwo.
	aTaskThree := self emptyValuableTask valuable: aBlockOne.
	aCollection addTask: aTaskOne.
	aCollection addTask: aTaskTwo.
	aCollection addTask: aTaskThree.
	self assert: aCollection size equals: 2.
	aCollection flush.
	self assert: aValue equals: 25.
	self assert: aCollection size equals: 0.
	^ aCollection
]
