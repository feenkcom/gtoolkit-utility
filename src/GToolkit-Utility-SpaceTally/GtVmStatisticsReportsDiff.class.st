Class {
	#name : #GtVmStatisticsReportsDiff,
	#superclass : #Object,
	#instVars : [
		'sourceReport',
		'targetReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

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
		text: [ self textualDiff ]
]

{ #category : #accessing }
GtVmStatisticsReportsDiff >> printTextualDiffOn: aStream [
	| fullGCs2 incrGCs2 upTime2 fullGCTime2 incrGCTime2 tenureCount2 |
	
	upTime2 := self targetReport upTime - self sourceReport upTime.
	fullGCs2 := self targetReport gargabeCollectionReport fullGCs 
		- self sourceReport gargabeCollectionReport fullGCs.
	fullGCTime2 := self targetReport gargabeCollectionReport fullGCTime
		- self sourceReport gargabeCollectionReport fullGCTime.
	incrGCs2 := self targetReport gargabeCollectionReport incrGCs
		- self sourceReport gargabeCollectionReport incrGCs.
	incrGCTime2 := self targetReport gargabeCollectionReport incrGCTime
		- self sourceReport gargabeCollectionReport incrGCTime.
	tenureCount2 := self targetReport gargabeCollectionReport tenureCount
		- self sourceReport gargabeCollectionReport tenureCount.
	
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
GtVmStatisticsReportsDiff >> textualDiff [
	^ String streamContents: [ :aStream |
		self printTextualDiffOn:  aStream ]
]
