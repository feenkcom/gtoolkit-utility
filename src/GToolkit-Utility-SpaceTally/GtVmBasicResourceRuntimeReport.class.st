Class {
	#name : #GtVmBasicResourceRuntimeReport,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'upTime'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #profiling }
GtVmBasicResourceRuntimeReport class >> recordNewReport [
	^ self new recordReportStatistics
]

{ #category : #'gt - extensions' }
GtVmBasicResourceRuntimeReport >> gtViewTextualStatisticsFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Statistics (textual)';
		text: [ self textualStatistics ]
]

{ #category : #printing }
GtVmBasicResourceRuntimeReport >> printOn: aStream [
	super printOn: aStream .
	
	aStream parenthesize: [ 
		aStream print: self timestamp.
		aStream << ', uptime: '.
		self printUpTimeOn:  aStream ]
]

{ #category : #printing }
GtVmBasicResourceRuntimeReport >> printTextualStatisticsOn: aStream [
]

{ #category : #printing }
GtVmBasicResourceRuntimeReport >> printUpTimeOn: aStream [ 

	aStream	
		print: (upTime / 1000 / 60 // 60); nextPut: $h;
		print: (upTime / 1000 / 60 \\ 60) asInteger; nextPut: $m;
		print: (upTime / 1000 \\ 60) asInteger; nextPut: $s.
]

{ #category : #profiling }
GtVmBasicResourceRuntimeReport >> recordReportStatistics [
	
	timestamp := DateAndTime now.
	upTime := Time millisecondClockValue.
]

{ #category : #printing }
GtVmBasicResourceRuntimeReport >> textualStatistics [
	^ String streamContents: [ :aStream |
		self printTextualStatisticsOn:  aStream ]
]

{ #category : #accessing }
GtVmBasicResourceRuntimeReport >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtVmBasicResourceRuntimeReport >> timestamp: anObject [

	timestamp := anObject
]

{ #category : #accessing }
GtVmBasicResourceRuntimeReport >> upTime [
	^ upTime
]

{ #category : #accessing }
GtVmBasicResourceRuntimeReport >> upTime: anObject [

	upTime := anObject
]

{ #category : #printing }
GtVmBasicResourceRuntimeReport >> upTimeDescription [
	^ String streamContents: [ :aStream |
		self printUpTimeOn: aStream ]
]
