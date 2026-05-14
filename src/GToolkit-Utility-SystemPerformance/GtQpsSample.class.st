Class {
	#name : #GtQpsSample,
	#superclass : #Object,
	#instVars : [
		'startTime',
		'endTime',
		'processes',
		'clockValue'
	],
	#category : #'GToolkit-Utility-SystemPerformance-Model'
}

{ #category : #'instance creation' }
GtQpsSample class >> sample [

	^ self new sample
]

{ #category : #accessing }
GtQpsSample >> duration [

	^ (endTime - clockValue) milliSeconds
]

{ #category : #ui }
GtQpsSample >> gtProcessesFor: aView [
	<gtView>

	processes ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Processes';
		priority: 20;
		items: [ processes ];
		column: 'Priority' text: [:item | item processPriority ] width: 100;
		column: 'Name' text: [:item | item processName ]
]

{ #category : #ui }
GtQpsSample >> gtSummaryFor: aView [
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
GtQpsSample >> processCount [

	^ processes
		ifNil: [ 0 ]
		ifNotNil: #size
]

{ #category : #accessing }
GtQpsSample >> processNames [

	^ processes
		ifNil: [ '' ]
		ifNotNil: [ ', ' join: (processes collect: #processName) ]
]

{ #category : #initialization }
GtQpsSample >> sample [
	| currentPriority quiescentProcesses |

	startTime := DateAndTime now.
	clockValue := Time millisecondClockValue.
	currentPriority := Processor activeProcess priority.
	quiescentProcesses := Processor gtQuiescentProcesses.
	processes := quiescentProcesses collect: [ :process |
		(process priority < currentPriority and:
		[ process priority > 10 ]) ifTrue:
			[ GtQpsProcess fromProcess: process ] ].
	endTime := Time millisecondClockValue.
	processes := processes reject: #isNil.
]

{ #category : #ui }
GtQpsSample >> summaryAttributes [

	processes ifNil: [ ^ {} ].

	^ {
		{ 'Start Time'. startTime. }.
		{ 'Duration'. self duration. }.
		{ 'Process count'. self processCount. }.
	}
]
