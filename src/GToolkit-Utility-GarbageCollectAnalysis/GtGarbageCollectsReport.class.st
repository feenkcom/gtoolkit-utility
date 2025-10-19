Class {
	#name : #GtGarbageCollectsReport,
	#superclass : #Object,
	#instVars : [
		'events',
		'overallParametersDiffReport'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #accessing }
GtGarbageCollectsReport >> events [
	^ events
]

{ #category : #accessing }
GtGarbageCollectsReport >> events: aCollection [
	events := aCollection
]

{ #category : #views }
GtGarbageCollectsReport >> gtOverallParametersDiffReportFor: aView [
	<gtView>
	^ aView forward
		title: 'Overall Parameters Diff';
		priority: 40;
		object: [ overallParametersDiffReport ];
		view: #gtViewChangedParametersFor:
]

{ #category : #views }
GtGarbageCollectsReport >> gtSummaryFor: aView [
	<gtView>

	^ aView columnedList
		  title: 'Summary';
		  priority: 5;
		  items: [ self summaryAttributes ];
		  column: #Attribute text: [ :item | item first ];
		  column: #Value text: [ :item | item second ].
]

{ #category : #views }
GtGarbageCollectsReport >> gtViewEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Events';
		priority: 10;
		object: [ events ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport [
	^ overallParametersDiffReport
]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport: aVmAllParametersDiffReport [
	overallParametersDiffReport := aVmAllParametersDiffReport
]

{ #category : #accessing }
GtGarbageCollectsReport >> recordedEventsDuration [
	^ events  
		inject: 0 seconds 
		into: [ :total  :anEvent | 
			total + anEvent duration ]
]

{ #category : #accessing }
GtGarbageCollectsReport >> summaryAttributes [
	"Answer a collection of key/value attributes that can simply be listed as a summary of the receiver"

	^ { 
		{ 'Total GC Count'. overallParametersDiffReport fullGcCountDiff diffFormattedValue diffDescription }.
		{ 'Total GC Duration'. overallParametersDiffReport fullGcDurationDiff diffFormattedValue diffDescription }.
		{'Not-recorded GC events' . overallParametersDiffReport fullGcCountDiff rawDiffValue - events size }.
		{'Recorded GC events' . events size }.
		{'Recorded events duation' . self recordedEventsDuration}.
		{'Events with basicNew source'. events numberOfEventsWithBasicNewSource}}
]
