Class {
	#name : #GtVmMemoryStatisticsReport,
	#superclass : #GtVmBasicResourceRuntimeReport,
	#instVars : [
		'memorySize',
		'oldSpaceSize',
		'youngSpaceSize',
		'freeSize'
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
GtVmMemoryStatisticsReport >> freeSize: anObject [

	freeSize := anObject
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> memorySize [
	^ memorySize
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> memorySize: anObject [

	memorySize := anObject
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> oldSpaceSize [
	^ oldSpaceSize
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> oldSpaceSize: anObject [

	oldSpaceSize := anObject
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

{ #category : #profiling }
GtVmMemoryStatisticsReport >> recordReportStatistics [
	| vm |
	
	super recordReportStatistics.
	vm := SmalltalkImage current vm.
	
	oldSpaceSize := vm oldSpace.
	youngSpaceSize := vm youngSpaceSize.
	memorySize := vm memorySize.
	freeSize := vm freeSize.
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> youngSpaceSize [
	^ youngSpaceSize
]

{ #category : #accessing }
GtVmMemoryStatisticsReport >> youngSpaceSize: anObject [

	youngSpaceSize := anObject
]
