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
	| process analyser commonStack |

	process := self forkLoop.
	analyser := GtProcessLoopAnalyser new process: process.
	commonStack := analyser run.

	self assert: commonStack size equals: 3.
	self assert: commonStack last selector equals: #doLoop.
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
