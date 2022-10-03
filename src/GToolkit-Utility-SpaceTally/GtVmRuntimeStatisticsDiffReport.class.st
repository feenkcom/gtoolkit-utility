Class {
	#name : #GtVmRuntimeStatisticsDiffReport,
	#superclass : #Object,
	#instVars : [
		'sourceReport',
		'targetReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport class >> leJsonV4Name [

	^ #gtVmStatisticsReportDiff
]

{ #category : #initialization }
GtVmRuntimeStatisticsDiffReport >> defaultReportClass [
	^ GtVmRuntimeStatisticsReport
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> fullGCsDiff [

	^ self targetReport gargabeCollectionReport fullGCs 
		- self sourceReport gargabeCollectionReport fullGCs.
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> fullGcTimeDiff [

	^ self targetReport gargabeCollectionReport fullGCTime
		- self sourceReport gargabeCollectionReport fullGCTime.
]

{ #category : #'gt - extensions' }
GtVmRuntimeStatisticsDiffReport >> gtViewReportsFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Reports';
		items: [ {self sourceReport. self targetReport} ];
		column: 'Timestamp' text: [ :aReport | aReport timestamp ];
		column: 'Up Time' text: [ :aReport | aReport upTimeDescription ];
		column: 'VM Memory' text: [ :aReport | 
			aReport vmMemorySize humanReadableIsqByteSize ]
]

{ #category : #'gt - extensions' }
GtVmRuntimeStatisticsDiffReport >> gtViewTextualDiffFor: aView [
	<gtView>
	
	self hasReports ifFalse: [ ^ aView empty].
	
	^ aView textEditor
		title: 'Difference (textual)';
		text: [ self textualDiff asRopedText glamorousCodeFont ]
]

{ #category : #testing }
GtVmRuntimeStatisticsDiffReport >> hasReports [
	^ self sourceReport notNil and: [ self targetReport notNil]
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> incrGCsDiff [

	^ self targetReport gargabeCollectionReport incrGCs
		- self sourceReport gargabeCollectionReport incrGCs.
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> incrGcTimeDiff [

	^ self targetReport gargabeCollectionReport incrGCTime
		- self sourceReport gargabeCollectionReport incrGCTime.
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printOn: aStream [
	(sourceReport isNil or: [ targetReport isNil ]) ifTrue:
		[ ^ super printOn: aStream ].
	
	aStream
		print: self totalGcTimeDiff;
		<< 'ms in GC'
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printTextualDiffOn: aStream [
	| fullGCs2 incrGCs2 upTime2 fullGCTime2 incrGCTime2 tenureCount2 |
	
	upTime2 := self uptimeDiff.
	fullGCs2 := self fullGCsDiff.
	fullGCTime2 := self fullGcTimeDiff.
	incrGCs2 := self incrGCsDiff.
	incrGCTime2 := self incrGcTimeDiff.
	tenureCount2 := self tenureCountDiff.
	
	aStream <<  'GC	'.
	(fullGCs2 + incrGCs2) printWithCommasOn: aStream.
	fullGCs2 + incrGCs2 > 0 ifTrue: [
		aStream
			<< ' ('; 
			print: ((upTime2 / (fullGCs2 + incrGCs2)) roundTo: 1); 
			<< 'ms between GCs)' ].
	aStream cr.
	
	aStream << '	uptime		'; print: ((upTime2 / 1000.0) roundTo: 0.1); << 's'; cr.
	aStream << '	full			';
		print: fullGCs2; << ' totalling '.
	fullGCTime2 printWithCommasOn: aStream.
	aStream << 'ms ('.
	upTime2 > 0 ifTrue: [
		aStream 
			print: ((fullGCTime2 / upTime2 * 100) roundTo: 0.1);
			<< '% uptime)' ].
	fullGCs2 > 0 ifTrue: [ 
		aStream	<< ', avg '; print: ((fullGCTime2 / fullGCs2) roundTo: 0.1); << 'ms' ].
	aStream cr.
	
	aStream << '	incr		';
		print: incrGCs2; << ' totalling '.
	incrGCTime2 printWithCommasOn: aStream.
	aStream 
		<< 'ms ('.
	upTime2 > 0 ifTrue: [
		aStream
			print: ((incrGCTime2 / upTime2 * 100) roundTo: 0.1);
			<< '% uptime), avg ' ].
	incrGCs2 > 0 ifTrue: [
		 aStream print: ((incrGCTime2 / incrGCs2) roundTo: 0.1); << 'ms' ].
	
	aStream cr.
	aStream << '	tenures		'.
	tenureCount2 printWithCommasOn: aStream.
	tenureCount2 > 0 ifTrue: [
		aStream << ' (avg '; print: (incrGCs2 / tenureCount2) asInteger; << ' GCs/tenure)' ].
	aStream cr.
]

{ #category : #profiling }
GtVmRuntimeStatisticsDiffReport >> recordSourceReport [
	^ self sourceReport: self defaultReportClass recordNewReport
]

{ #category : #profiling }
GtVmRuntimeStatisticsDiffReport >> recordTargetReport [
	^ self targetReport: self defaultReportClass recordNewReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> sourceReport [

	^ sourceReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> sourceReport: anObject [

	sourceReport := anObject
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> targetReport [

	^ targetReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> targetReport: anObject [

	targetReport := anObject
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> tenureCountDiff [

	^ self targetReport gargabeCollectionReport tenureCount
		- self sourceReport gargabeCollectionReport tenureCount.
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> textualDiff [
	^ String streamContents: [ :aStream |
		self printTextualDiffOn:  aStream ]
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> totalGcTimeDiff [ 
	^ self fullGcTimeDiff + self incrGcTimeDiff.
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> uptimeDiff [

	^ self targetReport upTime - self sourceReport upTime
]

{ #category : #'accessing - vm memory details' }
GtVmRuntimeStatisticsDiffReport >> vmFreeMemoryAtEnd [
	^ self targetReport vmFreeMemory
]

{ #category : #'accessing - vm memory details' }
GtVmRuntimeStatisticsDiffReport >> vmMaximumMemorySize [
	^ self vmMemorySizeAtEnd max: self vmMemorySizeAtEnd
]

{ #category : #'accessing - vm memory details' }
GtVmRuntimeStatisticsDiffReport >> vmMemorySizeAtEnd [
	^ self targetReport vmMemorySize
]

{ #category : #'accessing - vm memory details' }
GtVmRuntimeStatisticsDiffReport >> vmMemorySizeAtStart [
	^ self sourceReport vmMemorySize
]

{ #category : #'accessing - vm memory details' }
GtVmRuntimeStatisticsDiffReport >> vmMinimumMemorySize [
	^ self vmMemorySizeAtEnd min: self vmMemorySizeAtEnd
]
