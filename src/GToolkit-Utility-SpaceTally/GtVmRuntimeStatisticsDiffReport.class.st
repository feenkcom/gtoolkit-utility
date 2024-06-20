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
GtVmRuntimeStatisticsDiffReport >> fullGCsDiff [

	^ self targetReport gargabeCollectionReport fullGCs 
		- self sourceReport gargabeCollectionReport fullGCs.
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> fullGcDuration [  
	^ Duration milliSeconds: self fullGcTimeDiff
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
	| totalRunningDuration |

	totalRunningDuration := self totalRunningDuration.
	totalRunningDuration = 0 ifTrue: [ ^ 0 ].

	^ ((self totalGcDuration / totalRunningDuration) * 100.0 roundTo: 0.1)
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
		priority: 60;
		items: [ {self sourceReport. self targetReport} ];
		column: 'Timestamp' text: [ :aReport | aReport timestamp ];
		column: 'Up Time' text: [ :aReport | aReport upTimeDescription ];
		column: 'VM Memory' text: [ :aReport | 
			aReport vmMemorySize humanReadableIsqByteSize ]
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> incrGCsDiff [

	^ self targetReport gargabeCollectionReport incrGCs
		- self sourceReport gargabeCollectionReport incrGCs.
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> incrGcDuration [  
	^ Duration milliSeconds: self incrGcTimeDiff
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

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> memorySizeDiff [
	^ self targetReport vmMemorySize - self sourceReport vmMemorySize
]

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> oldSpaceSizeDiff [
	^ self targetReport oldSpaceSize - self sourceReport oldSpaceSize
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
GtVmRuntimeStatisticsDiffReport >> printGCTextualDiffOn: aStream [
	self garbageCollectionDiffReport 
		printTextualDiffOn: aStream
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printMemoryTextualDiffOn: aStream [
	| oldSpaceEnd youngSpaceEnd memoryEnd |
	oldSpaceEnd := self oldSpaceSizeDiff.
	youngSpaceEnd := self youngSpaceSizeDiff.
	memoryEnd := self memorySizeDiff.

	aStream
		nextPutAll: 'Memory'; cr.
	aStream
		nextPutAll:	'	old			';
		nextPutAll: oldSpaceEnd asStringWithCommasSigned; nextPutAll: ' bytes'; cr.
	aStream	
		nextPutAll: '	young		';
		nextPutAll: (youngSpaceEnd - oldSpaceEnd) asStringWithCommasSigned; nextPutAll: ' bytes';
		cr.
	aStream
		nextPutAll: '	used		';
		nextPutAll: youngSpaceEnd asStringWithCommasSigned; nextPutAll: ' bytes'; cr.
	aStream
		nextPutAll: '	free		';
		nextPutAll: (memoryEnd - youngSpaceEnd) asStringWithCommasSigned; nextPutAll: ' bytes'; cr.
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printOn: aStream [
	self hasReports ifFalse: [ 
		^ super printOn: aStream ].
	
	aStream
		print: self totalGcTimeDiff;
		<< 'ms in GC'.
		
	aStream << ', '.
	
	self memorySizeDiff < 0 ifTrue: [
		aStream << '-' ].
	aStream 
		<< self memorySizeDiff abs humanReadableSISizeString;
		<< ' change in total memory'
]

{ #category : #printing }
GtVmRuntimeStatisticsDiffReport >> printTextualDiffOn: aStream [
	self printMemoryTextualDiffOn: aStream.
	aStream cr.
	self printGCTextualDiffOn: aStream.
]

{ #category : #accessing }
GtVmRuntimeStatisticsDiffReport >> reportSummaryValues [
	| totalRunningDuration |
	
	totalRunningDuration := self totalRunningDuration.
	^ {
		'Total Time' -> totalRunningDuration.
		'Total GC Percentage' -> (totalRunningDuration = 0
			ifTrue: [ 'N/A' ]
			ifFalse: [ ((self gcRunningTimePercentage
				printShowingDecimalPlaces: 2), ' %') ]).
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

{ #category : #'accessing - gc details' }
GtVmRuntimeStatisticsDiffReport >> youngSpaceSizeDiff [
	^ self targetReport youngSpaceSize - self sourceReport youngSpaceSize
]
