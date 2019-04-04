"
I examplify Tasker. I recommend you to start exploring documentation at ${class:GtProtoTasker}$.
"
Class {
	#name : #GtTaskerExamples,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #basic }
GtTaskerExamples >> addingManySameTasksToPostponingTasker [
	<gtExample>
	| aTasker aSemaphore aValue aBlock aTask wasTimeouted |
	aTasker := self basicPostponingTasker.
	aSemaphore := Semaphore new.
	aValue := 0.
	aBlock := [ aValue := aValue + 1 ].
	aTask := self emptyValuableTask valuable: aBlock.
	50 timesRepeat: [ aTasker addTask: aTask ].
	aTasker addTask: (self emptyValuableTask valuable: [ aSemaphore signal ]).
	wasTimeouted := aSemaphore waitTimeoutMSecs: aTasker suspencion asMilliSeconds * 5.
	self assert: wasTimeouted not.
	self assert: aValue equals: 1.
	^ aTasker
]

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
	aSubTasker := self emptyOrderedNonRepetitiveTasker.
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
GtTaskerExamples >> flushOrderedNonRepetitiveTasker [
	<gtExample>
	| aTasker |
	aTasker := self keepOrderInOrderedNonRepetitiveTasker.
	aTasker flush.
	self assert: value equals: 25.
	self assert: aTasker size equals: 0.
	^ aTasker
]

{ #category : #basic }
GtTaskerExamples >> keepOrderInOrderedNonRepetitiveTasker [
	<gtExample>
	| aTasker aTaskOne aBlockOne aBlockTwo aTaskTwo aTaskThree |
	aTasker := self emptyOrderedNonRepetitiveTasker.
	value := 2.
	aBlockOne := [ value := value + 3 ].
	aBlockTwo := [ value := value * 5 ].
	aTaskOne := self emptyValuableTask valuable: aBlockOne.
	aTaskTwo := self emptyValuableTask valuable: aBlockTwo.
	aTaskThree := self emptyValuableTask valuable: aBlockOne.
	aTasker addTask: aTaskOne.
	aTasker addTask: aTaskTwo.
	aTasker addTask: aTaskThree.
	self assert: aTasker size equals: 2.
	self assert: aTasker collection asOrderedCollection first equals: aTaskThree.
	self assert: aTasker collection asOrderedCollection second equals: aTaskTwo.
	^ aTasker
]
