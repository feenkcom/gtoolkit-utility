Class {
	#name : #GtVmGarbageCollectionReport,
	#superclass : #GtVmBasicResourceRuntimeReport,
	#instVars : [
		'fullGCs',
		'fullGCTime',
		'incrGCs',
		'incrGCTime',
		'tenureCount'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmGarbageCollectionReport class >> leJsonV4Name [

	^ #gtVmGarbageCollectionReport
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> fullGCTime [
	^ fullGCTime
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> fullGCTime: anObject [

	fullGCTime := anObject
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> fullGCs [
	^ fullGCs
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> fullGCs: anObject [

	fullGCs := anObject
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCTime [
	^ incrGCTime
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCTime: anObject [

	incrGCTime := anObject
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCs [
	^ incrGCs
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCs: anObject [

	incrGCs := anObject
]

{ #category : #printing }
GtVmGarbageCollectionReport >> printReportValuesOn: aStream prefix: aPrefix [
	aStream	
		<< aPrefix; << 'fullGCs = '; print: fullGCs;
		cr;
		<< aPrefix; << 'fullGCTime = '; print: fullGCTime;
		cr;
		<< aPrefix; << 'incrGCs = '; print: incrGCs;
		cr;
		<< aPrefix; << 'incrGCTime = '; print: incrGCTime;
		cr;
		<< aPrefix; << 'tenureCount = '; print: tenureCount.
]

{ #category : #printing }
GtVmGarbageCollectionReport >> printTextualStatisticsOn: aStream [
	aStream << 'GCs				'.
	(fullGCs + incrGCs) printWithCommasOn: aStream.
	fullGCs + incrGCs > 0 ifTrue: [
		aStream
			<< ' ('; 
			print: ((upTime / (fullGCs + incrGCs)) roundTo: 1); 
			<< 'ms between GCs)' ].
	
	aStream cr.
	aStream << '	full			';
		print: fullGCs; << ' totalling '.
	fullGCTime printWithCommasOn: aStream.
	aStream << 'ms (';
		print: ((fullGCTime / upTime * 100) roundTo: 0.1);
		<< '% uptime)'.
	fullGCs = 0 ifFalse:
		[aStream	<< ', avg '; print: ((fullGCTime / fullGCs) roundTo: 0.1); << 'ms'].
	aStream cr.
	aStream<< '	incr		';
		print: incrGCs; << ' totalling '.
	incrGCTime printWithCommasOn: aStream.
	aStream << 'ms (';
		print: ((incrGCTime / upTime * 100) roundTo: 0.1);
		<< '% uptime), avg '; print: ((incrGCTime / incrGCs) roundTo: 0.1); << 'ms'; cr.
	aStream << '	tenures		'.
	
	tenureCount printWithCommasOn: aStream.
	tenureCount = 0 ifFalse: [
		aStream << ' (avg '; print: (incrGCs / tenureCount) asInteger; << ' GCs/tenure)' ].
	
	aStream cr.
]

{ #category : #profiling }
GtVmGarbageCollectionReport >> recordReportStatistics [
	| vm |
	
	super recordReportStatistics.
	vm := SmalltalkImage current vm.
	
	tenureCount := vm tenureCount.
	fullGCs := vm fullGCCount.
	fullGCTime := vm totalFullGCTime.
	incrGCs := vm incrementalGCCount.
	incrGCTime := vm totalIncrementalGCTime.
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> tenureCount [

	^ tenureCount
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> tenureCount: anObject [

	tenureCount := anObject
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> totalGcCount [
	^ self fullGCs + self incrGCs
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> totalGcDuration [
	^ Duration milliSeconds: self totalGcTime
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> totalGcTime [ 
	^ self fullGCTime + self incrGCTime
]
