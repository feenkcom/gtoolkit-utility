Class {
	#name : #GtVmRuntimeStatisticsReport,
	#superclass : #GtVmBasicResourceRuntimeReport,
	#instVars : [
		'gargabeCollectionReport',
		'memoryStatisticsReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmRuntimeStatisticsReport class >> leJsonV4Name [
	^ #gtVmRuntimeStatisticsReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> gargabeCollectionReport [

	^ gargabeCollectionReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> gargabeCollectionReport: anObject [

	gargabeCollectionReport := anObject
]

{ #category : #'gt - extensions' }
GtVmRuntimeStatisticsReport >> gtViewReportsFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Reports';
		items: [ self reports]
]

{ #category : #initialization }
GtVmRuntimeStatisticsReport >> initialize [
	super initialize.
	
	gargabeCollectionReport := GtVmGarbageCollectionReport new.
	memoryStatisticsReport := GtVmMemoryStatisticsReport new.
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> memoryStatisticsReport [

	^ memoryStatisticsReport
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> memoryStatisticsReport: anObject [

	memoryStatisticsReport := anObject
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> printTextualStatisticsOn: aStream [
	aStream	
		<< 'uptime			'.
	self printUpTimeOn:  aStream.
	aStream cr.
	
	self reports do: [ :aReport |
		aReport printTextualStatisticsOn:  aStream ]
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> recordReportStatistics [
	super recordReportStatistics.
	
	self reports do: [ :aReport |
		aReport recordReportStatistics.
		aReport upTime: self upTime ]
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> reports [
	^ { memoryStatisticsReport. gargabeCollectionReport}
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> vmFreeMemory [
	^ self memoryStatisticsReport freeSize
]

{ #category : #accessing }
GtVmRuntimeStatisticsReport >> vmMemorySize [ 
	^ self memoryStatisticsReport memorySize
]
