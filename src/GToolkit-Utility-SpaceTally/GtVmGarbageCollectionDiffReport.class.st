Class {
	#name : #GtVmGarbageCollectionDiffReport,
	#superclass : #GtVmBasicRuntimeStatisticsDiffReport,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmGarbageCollectionDiffReport >> defaultReportClass [
	^ GtVmGarbageCollectionReport
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> fullGCsDiff [

	^ self targetReport fullGCs 
		- self sourceReport fullGCs.
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> fullGcTimeDiff [

	^ self targetReport fullGCTime
		- self sourceReport fullGCTime.
]

{ #category : #printing }
GtVmGarbageCollectionDiffReport >> fullTextualContent [
	^ String streamContents: [ :aStream |
		self printFullTextualContentOn:  aStream ]
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> incrGCsDiff [

	^ self targetReport incrGCs
		- self sourceReport incrGCs.
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> incrGcTimeDiff [

	^ self targetReport incrGCTime
		- self sourceReport incrGCTime.
]

{ #category : #printing }
GtVmGarbageCollectionDiffReport >> printFullTextualContentOn: aStream [
	
	self printTextualDiffOn: aStream.
]

{ #category : #printing }
GtVmGarbageCollectionDiffReport >> printOn: aStream [
	self hasReports ifFalse: [ 
		^ super printOn: aStream ].
	
	aStream
		print: self totalGcTimeDiff;
		<< 'ms in GC'.
]

{ #category : #printing }
GtVmGarbageCollectionDiffReport >> printTextualDiffOn: aStream [
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
GtVmGarbageCollectionDiffReport >> reportSummaryValues [
	^ {
	'Total GC Time' -> (Duration milliSeconds:  self totalGcTimeDiff).
	'Full GC Time' -> (Duration milliSeconds:  self fullGcTimeDiff).
	'Incremental GC Time' -> (Duration milliSeconds:  self incrGcTimeDiff).
	
	'Full GC Count' -> self fullGCsDiff.
	'Incremental GC Count' -> self incrGCsDiff.
	
	'Average Full GC Time' -> (self fullGCsDiff isZero 
		ifFalse: [(Duration milliSeconds: self fullGcTimeDiff / self fullGCsDiff)]
		ifTrue: [ '-' ]). 
	'Average Incremental GC Time' -> (self incrGCsDiff isZero 
		ifFalse: [(Duration milliSeconds: self incrGcTimeDiff / self incrGCsDiff)]
		ifTrue: [ '-' ])
	}	  
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> tenureCountDiff [
	^ self targetReport tenureCount
		- self sourceReport tenureCount.
]

{ #category : #printing }
GtVmGarbageCollectionDiffReport >> textualDiff [
	^ String streamContents: [ :aStream |
		self printTextualDiffOn:  aStream ]
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> totalGcDuration [  
	^ Duration milliSeconds: self totalGcTimeDiff
]

{ #category : #accessing }
GtVmGarbageCollectionDiffReport >> totalGcTimeDiff [ 
	^ self fullGcTimeDiff + self incrGcTimeDiff.
]
