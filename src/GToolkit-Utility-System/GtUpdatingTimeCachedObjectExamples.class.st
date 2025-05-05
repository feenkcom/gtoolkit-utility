Class {
	#name : #GtUpdatingTimeCachedObjectExamples,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GtUpdatingTimeCachedObjectExamples >> basicOperation [
	"Demonstrate basic operation of the cache"

	<gtExample>
	<after: #cleanUp>
	<return: #GtUpdatingTimeCachedObject>
	| process value1 value2 |
	"The following two steps will fail in the debugger."
	process := Processor activeProcess.
	process
		at: process priority - 1
		do: [ cache := GtUpdatingTimeCachedObject
					get: [ 1 second wait.
						DateAndTime now ]
					timeout: 2 seconds
					active: 10 seconds ].
	self assert: cache value isNil.
	1.5 seconds wait.
	value1 := cache value.
	self assert: value1 class equals: DateAndTime.
	2 seconds wait.
	value2 := cache value.
	self assert: value2 - value1 >= 1 second.
	^ cache
]

{ #category : #private }
GtUpdatingTimeCachedObjectExamples >> cleanUp [

	cache ifNotNil:
		[ cache stop.
		cache := nil ]
]
