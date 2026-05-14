Class {
	#name : #GtQpsProcess,
	#superclass : #Object,
	#instVars : [
		'processName',
		'processHash',
		'processPriority',
		'stack',
		'timestamp'
	],
	#category : #'GToolkit-Utility-SystemPerformance-Model'
}

{ #category : #'instance creation' }
GtQpsProcess class >> fromProcess: aProcess [

	^ self new fromProcess: aProcess
]

{ #category : #initialization }
GtQpsProcess >> fromProcess: aProcess [

	timestamp := Time millisecondClockValue.
	processName := aProcess name.
	processHash := aProcess identityHash.
	processPriority := aProcess priority.
	stack := self stackFrom: aProcess.
]

{ #category : #ui }
GtQpsProcess >> gtStackFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Stack';
		priority: 20;
		items: [ stack ];
		column: 'Call frame' text: [:item | item classname asString, '>>', item selector asString ]
]

{ #category : #ui }
GtQpsProcess >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ self summaryAttributes ];
		column: #Attribute text: [:item | item first] width: 100;
		column: #Value text: [:item | item second];
		send: [:item | item last ]
]

{ #category : #accessing }
GtQpsProcess >> processHash [
	^processHash
]

{ #category : #accessing }
GtQpsProcess >> processHash: anObject [
	processHash := anObject
]

{ #category : #accessing }
GtQpsProcess >> processName [
	^processName
]

{ #category : #accessing }
GtQpsProcess >> processName: anObject [
	processName := anObject
]

{ #category : #accessing }
GtQpsProcess >> processPriority [
	^processPriority
]

{ #category : #accessing }
GtQpsProcess >> processPriority: anObject [
	processPriority := anObject
]

{ #category : #accessing }
GtQpsProcess >> stack [
	^stack
]

{ #category : #accessing }
GtQpsProcess >> stack: anObject [
	stack := anObject
]

{ #category : #private }
GtQpsProcess >> stackFrom: aProcess [

	^ (aProcess suspendedContext stackOfSize: 50) collect: [ :context |
		GtQpsStackEntry new
			classname: context methodClass name;
			selector: context selector ]
				as: Array.
]

{ #category : #ui }
GtQpsProcess >> summaryAttributes [

	^ {
		{ 'Name'. processName. }.
		{ 'Hash'. processHash. }.
		{ 'Priority'. processPriority }.
		{ 'Stack size'. stack size. }.
		}
]

{ #category : #accessing }
GtQpsProcess >> timestamp [
	^timestamp
]

{ #category : #accessing }
GtQpsProcess >> timestamp: anObject [
	timestamp := anObject
]
