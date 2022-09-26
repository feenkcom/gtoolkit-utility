Class {
	#name : #GtVmRuntimeReport,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'upTime'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'gt - extensions' }
GtVmRuntimeReport >> gtViewTextualStatisticsFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Statistics (textual)';
		text: [ self textualStatistics ]
]

{ #category : #printing }
GtVmRuntimeReport >> printOn: aStream [
	super printOn: aStream .
	
	aStream parenthesize: [ 
		aStream print: self timestamp.
		aStream << ', uptime: '.
		self printUpTimeOn:  aStream ]
]

{ #category : #printing }
GtVmRuntimeReport >> printTextualStatisticsOn: aStream [
]

{ #category : #printing }
GtVmRuntimeReport >> printUpTimeOn: aStream [ 

	aStream	
		print: (upTime / 1000 / 60 // 60); nextPut: $h;
		print: (upTime / 1000 / 60 \\ 60) asInteger; nextPut: $m;
		print: (upTime / 1000 \\ 60) asInteger; nextPut: $s.
]

{ #category : #profiling }
GtVmRuntimeReport >> recordReportStatistics [
	
	timestamp := DateAndTime now.
	upTime := Time millisecondClockValue.
]

{ #category : #printing }
GtVmRuntimeReport >> textualStatistics [
	^ String streamContents: [ :aStream |
		self printTextualStatisticsOn:  aStream ]
]

{ #category : #accessing }
GtVmRuntimeReport >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtVmRuntimeReport >> upTime [
	^ upTime
]

{ #category : #accessing }
GtVmRuntimeReport >> upTime: anObject [

	upTime := anObject
]
