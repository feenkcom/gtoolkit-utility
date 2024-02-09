Class {
	#name : #GtVmRuntimeStatisticsDiffReport,
	#superclass : #GtVmBasicRuntimeStatisticsDiffReport,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmRuntimeStatisticsDiffReport class >> leJsonV4Name [

	^ #gtVmRuntimeStatisticsDiffReport
]

{ #category : #initialization }
GtVmRuntimeStatisticsDiffReport >> defaultReportClass [
	^ GtVmRuntimeStatisticsReport
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> fullGcDuration [  
	^ Duration milliSeconds: self fullGcTimeDiff
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

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> fullTextualContent [
	^ String streamContents: [ :aStream |
		self printFullTextualContentOn:  aStream ]
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> garbageCollectionDiffReport [
	^ GtVmGarbageCollectionDiffReport new
		sourceReport:  self sourceReport gargabeCollectionReport ;
		targetReport: self targetReport gargabeCollectionReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> gcRunningTimePercentage [
	^ ((self totalGcDuration / self totalRunningDuration ) * 100.0 roundTo: 0.1)
]

{ #category : #'memory usage' }
GtVmRuntimeStatisticsDiffReport >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ ((label notNil and: [ label isString] )
			ifTrue: [ label sizeInMemory ]
			ifFalse: [ 0 ])
]

{ #category : #'gt - extensions' }
GtVmRuntimeStatisticsDiffReport >> gtViewFullTextualDescriptionFor: aView [
	<gtView>
	
	self hasReports ifFalse: [ ^ aView empty].
	
	^ aView textEditor
		title: 'Full textual report';
		text: [ self fullTextualContent ];
		actionUpdateButton
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
GtVmRuntimeStatisticsDiffReport >> incrGcDuration [  
	^ Duration milliSeconds: self incrGcTimeDiff
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

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> label [
	^ label
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> label: aLabel [
	label := aLabel
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printFullTextualContentOn: aStream [
	aStream << 'Report Overview'; cr.
	self printSummaryValuesOn: aStream.
	
	aStream cr.
	self printTextualDiffOn: aStream.
	
	aStream cr; << 'Source Report Details'; cr.
	self sourceReport printTextualStatisticsOn: aStream.
	
	aStream cr; << 'Target Report Details'; cr.
	self targetReport printTextualStatisticsOn: aStream.
	
	aStream cr; << 'Source Report Values'; cr.
	self sourceReport 
		printReportValuesOn: aStream
		prefix: String tab.

	aStream cr; cr; << 'Target Report Values'; cr.
	self targetReport 
		printReportValuesOn: aStream
		prefix: String tab.
	
	aStream cr; cr; << 'Report STON: '.
	STON put: self onStream: aStream
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printOn: aStream [
	self hasReports ifFalse: [ 
		^ super printOn: aStream ].
	
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
	
	aStream <<  'GC Diff	'.
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

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> reportSummaryValues [
	^ {
		'Total Time' -> self totalRunningDuration.
		'Total GC Percentage' -> ((self gcRunningTimePercentage
			printShowingDecimalPlaces: 2), ' %').
	}
		, self garbageCollectionDiffReport reportSummaryValues
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
GtVmRuntimeStatisticsDiffReport >> totalGcDuration [  
	^ Duration milliSeconds: self totalGcTimeDiff
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> totalGcTimeDiff [ 
	^ self fullGcTimeDiff + self incrGcTimeDiff.
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> totalRunningDuration [
	^ self targetReport timestamp - self sourceReport timestamp
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
