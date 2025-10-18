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
GtGarbageCollectsReport >> gtViewEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Events';
		priority: 10;
		items: [ events ];
		column: 'Time' text: [ :each | each startTime asTime print24 ] width: 70;
		column: 'Source' text: [ :each | each sourceDescription ];
		column: 'Duration' text: [ :each | each duration gtShortPrintString ];
		column: 'Removed Space' text: [ :each | each reducedOldSpaceSizeDescription ];
		column: 'Largest Free Chunk' text: [ :each | 
			each largestFreeChunkSizeDescription];
		column: 'Final Old Space' text: [ :each | 
			each parametersDiffReport targetReport oldSpaceSizeParameter formattedParameterValue  ]
]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport [
	^ overallParametersDiffReport
]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport: aVmAllParametersDiffReport [
	overallParametersDiffReport := aVmAllParametersDiffReport
]
