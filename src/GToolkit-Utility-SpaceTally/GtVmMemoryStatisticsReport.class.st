Class {
	#name : #GtVmMemoryStatisticsReport,
	#superclass : #GtVmRuntimeReport,
	#instVars : [
		'memorySize',
		'oldSpaceSize',
		'youngSpaceSize',
		'freeSize',
		'tenureCount'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmMemoryStatisticsReport class >> leJsonV4Name [
	^ #gtVmMemoryStatisticsReport
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> freeSize [
	^ freeSize
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> memorySize [
	^ memorySize
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> oldSpaceSize [
	^ oldSpaceSize
]

{ #category : #printings }
GtVmMemoryStatisticsReport >> printTextualStatisticsOn: aStream [
	aStream << 'memory			'.
	memorySize printWithCommasOn: aStream.
	aStream << ' bytes'; cr.
	aStream << '	old			'.
	oldSpaceSize printWithCommasOn: aStream.
	aStream << ' bytes (';
		print: ((oldSpaceSize / memorySize * 100) roundTo: 0.1); << '%)'; cr.
	aStream << '	young		'.
	(youngSpaceSize) printWithCommasOn: aStream.
	aStream << ' bytes (';
		print: ((youngSpaceSize / memorySize * 100) roundTo: 0.1); << '%)'; cr.
	aStream << '	used		'.
	youngSpaceSize + oldSpaceSize - freeSize printWithCommasOn: aStream.
	aStream << ' bytes (';
		print: ((youngSpaceSize + oldSpaceSize - freeSize / memorySize * 100) roundTo: 0.1); << '%)'; cr.
	aStream << '	free		'.
	freeSize printWithCommasOn: aStream.
	aStream << ' bytes (';
		print: ((freeSize / memorySize * 100) roundTo: 0.1); << '%)'; cr.
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> recordReportStatistics [
	| vm |
	
	super recordReportStatistics.
	vm := SmalltalkImage current vm.
	
	oldSpaceSize := vm oldSpace.
	youngSpaceSize := vm youngSpaceSize.
	tenureCount := vm tenureCount.
	memorySize := vm memorySize.
	freeSize := vm freeSize.
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> tenureCount [
	^ tenureCount
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> youngSpaceSize [
	^ youngSpaceSize
]
