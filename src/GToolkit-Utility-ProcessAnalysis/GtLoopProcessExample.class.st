Class {
	#name : #GtLoopProcessExample,
	#superclass : #Object,
	#instVars : [
		'loopSemaphore'
	],
	#category : #'GToolkit-Utility-ProcessAnalysis'
}

{ #category : #examples }
GtLoopProcessExample >> analyseLoop [
	<gtExample>
	<return: #GtLoopProcessExample>
	| process analyser commonStack |
	process := self forkLoop.
	analyser := GtProcessLoopAnalyser new process: process.
	commonStack := analyser run commonStack.
	self assert: commonStack first selector equals: #doLoop.
	self assert: commonStack third selector equals: #newProcess
]

{ #category : #private }
GtLoopProcessExample >> doLoop [

	1 to: 40 do: [ :i | self shortWait ].
	loopSemaphore signal.
]

{ #category : #private }
GtLoopProcessExample >> forkLoop [

	^ [ self doLoop ] fork.
]

{ #category : #initialize }
GtLoopProcessExample >> initialize [

	super initialize.
	loopSemaphore := Semaphore new.
]

{ #category : #private }
GtLoopProcessExample >> shortWait [

	50 milliseconds wait.
]
