Class {
	#name : #GtVmGarbageCollectionReport,
	#superclass : #GtVmRuntimeReport,
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
GtVmGarbageCollectionReport >> fullGCs [
	^ fullGCs
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCTime [
	^ incrGCTime
]

{ #category : #accessing }
GtVmGarbageCollectionReport >> incrGCs [
	^ incrGCs
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
