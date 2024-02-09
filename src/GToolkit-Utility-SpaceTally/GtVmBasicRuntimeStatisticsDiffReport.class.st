Class {
	#name : #GtVmBasicRuntimeStatisticsDiffReport,
	#superclass : #Object,
	#instVars : [
		'sourceReport',
		'targetReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #testing }
GtVmBasicRuntimeStatisticsDiffReport class >> isAbstract [
	^ self class name = #GtVmBasicRuntimeStatisticsDiffReport
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> defaultReportClass [
	self subclassResponsibility
]

{ #category : #'memory usage' }
GtVmBasicRuntimeStatisticsDiffReport >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ (sourceReport
			ifNil: [ 0]
			ifNotNil: [ :aReport | aReport gtSpecificSizeInMemory ])
		+ (targetReport
			ifNil: [ 0]
			ifNotNil: [ :aReport | aReport gtSpecificSizeInMemory ])
]

{ #category : #'gt - extensions' }
GtVmBasicRuntimeStatisticsDiffReport >> gtViewSummaryValuesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Summary values';
		items: [ self reportSummaryValues ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> printSummaryValuesOn: aStream [
	self reportSummaryValues 
		do: [ :assoc |
			aStream 
				tab;
				<< assoc key;
				<< ' = ';
				print: assoc value ]
		separatedBy: [ aStream cr ].
	aStream cr.
]

{ #category : #profiling }
GtVmBasicRuntimeStatisticsDiffReport >> recordSourceReport [
	^ self sourceReport: self defaultReportClass recordNewReport
]

{ #category : #profiling }
GtVmBasicRuntimeStatisticsDiffReport >> recordTargetReport [
	^ self targetReport: self defaultReportClass recordNewReport
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> reportSummaryValues [
	^ #()
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> sourceReport [

	^ sourceReport
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> sourceReport: anObject [

	sourceReport := anObject
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> targetReport [

	^ targetReport
]

{ #category : #accessing }
GtVmBasicRuntimeStatisticsDiffReport >> targetReport: anObject [

	targetReport := anObject
]
