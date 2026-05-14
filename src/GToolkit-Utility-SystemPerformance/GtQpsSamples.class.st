"
GtQpsSamples provides a mechanism for measuring the system load of a specified time period.

The result is similar to the `load average` figure from the linux `top` utility, i.e. we want the average load, i.e. the `Count` column in the {{gtClass:GtQpsSamples}} `Samples` view to regular have a value of 0 or 1.  Long sequences where the value is greater than 1 indicates that the system is CPU limited.

For processes that are taking more than the exepected time the call stack is provided with each sample.

Note that the sample should be run at high priority as it only records processes of lower priority than the sample process.
"
Class {
	#name : #GtQpsSamples,
	#superclass : #Object,
	#instVars : [
		'duration',
		'count',
		'samples',
		'priority'
	],
	#category : #'GToolkit-Utility-SystemPerformance-Model'
}

{ #category : #accessing }
GtQpsSamples >> count [
	^count
]

{ #category : #accessing }
GtQpsSamples >> count: anObject [
	count := anObject
]

{ #category : #accessing }
GtQpsSamples >> duration [
	^duration
]

{ #category : #accessing }
GtQpsSamples >> duration: anObject [
	duration := anObject
]

{ #category : #api }
GtQpsSamples >> gather [
	| delay |

	priority := Processor activeProcess priority.
	delay := (duration asSeconds / count) asFloat seconds.
	samples := OrderedCollection new.
	count-1 timesRepeat:
		[ samples add: GtQpsSample sample.
		delay wait. ].
	samples add: GtQpsSample sample.
]

{ #category : #ui }
GtQpsSamples >> gtSamplesFor: aView [
	<gtView>
	
	samples ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Samples';
		priority: 10;
		items: [ samples ];
		column: 'Count' text: [ :item | item processCount ] width: 100;
		column: 'Process Names' text: [ :item | item processNames ]
]

{ #category : #ui }
GtQpsSamples >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ self summaryAttributes ];
		column: #Attribute text: [:item | item first] width: 100;
		column: #Value text: [:item | item second];
		send: [:item | item last ]
]

{ #category : #ui }
GtQpsSamples >> summaryAttributes [

	^ {
		{ 'Count'. count. }.
		{ 'Duration'. duration. }.
		}
]
