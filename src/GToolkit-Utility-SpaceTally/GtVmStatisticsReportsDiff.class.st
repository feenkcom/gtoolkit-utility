Class {
	#name : #GtVmStatisticsReportsDiff,
	#superclass : #Object,
	#instVars : [
		'sourceReport',
		'targetReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmStatisticsReportsDiff class >> leJsonV4Name [

	^ #gtVmStatisticsReportDiff
]

{ #category : #initialization }
GtVmStatisticsReportsDiff >> defaultReportClass [
	^ GtVmStatisticsReport
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> fullGCsDiff [

	^ self targetReport gargabeCollectionReport fullGCs 
		- self sourceReport gargabeCollectionReport fullGCs.
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> fullGcTimeDiff [

	^ self targetReport gargabeCollectionReport fullGCTime
		- self sourceReport gargabeCollectionReport fullGCTime.
]

{ #category : #'gt - extensions' }
GtVmStatisticsReportsDiff >> gtViewReportsFor: aView [ 
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
GtVmStatisticsReportsDiff >> gtViewTextualDiffFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Difference (textual)';
		text: [ self textualDiff asRopedText glamorousCodeFont ]
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> incrGCsDiff [

	^ self targetReport gargabeCollectionReport incrGCs
		- self sourceReport gargabeCollectionReport incrGCs.
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> incrGcTimeDiff [

	^ self targetReport gargabeCollectionReport incrGCTime
		- self sourceReport gargabeCollectionReport incrGCTime.
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> printOn: aStream [
	(sourceReport isNil or: [ targetReport isNil ]) ifTrue:
		[ ^ super printOn: aStream ].
	
	aStream
		print: self totalGcTimeDiff;
		<< 'ms in GC'
]

{ #category : #printing }
GtVmStatisticsReportsDiff >> printTextualDiffOn: aStream [
	| fullGCs2 incrGCs2 upTime2 fullGCTime2 incrGCTime2 tenureCount2 |
	
	upTime2 := self uptimeDiff.
	fullGCs2 := self fullGCsDiff.
	fullGCTime2 := self fullGcTimeDiff.
	incrGCs2 := self incrGCsDiff.
	incrGCTime2 := self incrGcTimeDiff.
	tenureCount2 := self tenureCountDiff.
	
	aStream	<<  'GC	'.
	(fullGCs2 + incrGCs2) printWithCommasOn: aStream.
	fullGCs2 + incrGCs2 > 0 ifTrue: [
		aStream
			<< ' ('; 
			print: ((upTime2 / (fullGCs2 + incrGCs2)) roundTo: 1); 
			<< 'ms between GCs)'.
	].
	aStream cr.
	aStream	<< '	uptime		'; print: ((upTime2 / 1000.0) roundTo: 0.1); << 's'; cr.
	aStream	<< '	full			';
		print: fullGCs2; << ' totalling '.
	fullGCTime2 printWithCommasOn: aStream.
	aStream << 'ms (';
		print: ((fullGCTime2 / upTime2 * 100) roundTo: 0.1);
		<< '% uptime)'.
	fullGCs2 = 0 ifFalse:
		[aStream	<< ', avg '; print: ((fullGCTime2 / fullGCs2) roundTo: 0.1); << 'ms'].
	aStream	cr.
	aStream	<< '	incr		';
		print: incrGCs2; << ' totalling '.
	incrGCTime2 printWithCommasOn: aStream.
	aStream << 'ms (';
		print: ((incrGCTime2 / upTime2 * 100) roundTo: 0.1);
		<< '% uptime), avg '.
	incrGCs2 > 0 ifTrue: [
		 aStream print: ((incrGCTime2 / incrGCs2) roundTo: 0.1); << 'ms'
	].
	aStream cr.
	aStream	<< '	tenures		'.
	tenureCount2 printWithCommasOn: aStream.
	tenureCount2 isZero ifFalse:
		[aStream << ' (avg '; print: (incrGCs2 / tenureCount2) asInteger; << ' GCs/tenure)'].
	aStream	cr.
	
]

{ #category : #profiling }
GtVmStatisticsReportsDiff >> recordSourceReport [
	^ self sourceReport: self defaultReportClass recordNewReport
]

{ #category : #profiling }
GtVmStatisticsReportsDiff >> recordTargetReport [
	^ self targetReport: self defaultReportClass recordNewReport
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> sourceReport [

	^ sourceReport
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> sourceReport: anObject [

	sourceReport := anObject
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> targetReport [

	^ targetReport
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> targetReport: anObject [

	targetReport := anObject
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> tenureCountDiff [

	^ self targetReport gargabeCollectionReport tenureCount
		- self sourceReport gargabeCollectionReport tenureCount.
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> textualDiff [
	^ String streamContents: [ :aStream |
		self printTextualDiffOn:  aStream ]
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> totalGcTimeDiff [ 
	^ self fullGcTimeDiff + self incrGcTimeDiff.
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> uptimeDiff [

	^ self targetReport upTime - self sourceReport upTime
]
