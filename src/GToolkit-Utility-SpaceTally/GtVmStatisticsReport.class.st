Class {
	#name : #GtVmStatisticsReport,
	#superclass : #GtVmRuntimeReport,
	#instVars : [
		'gargabeCollectionReport',
		'memoryStatisticsReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmStatisticsReport class >> leJsonV4Name [
	^ #gtVmStatisticsReport
]

{ #category : #accessing }
GtVmStatisticsReport >> gargabeCollectionReport [

	^ gargabeCollectionReport
]

{ #category : #'gt - extensions' }
GtVmStatisticsReport >> gtViewReportsFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Reports';
		items: [ self reports]
]

{ #category : #initialization }
GtVmStatisticsReport >> initialize [
	super initialize.
	
	gargabeCollectionReport := GtVmGarbageCollectionReport new.
	memoryStatisticsReport := GtVmMemoryStatisticsReport new.
]

{ #category : #accessing }
GtVmStatisticsReport >> memoryStatisticsReport [

	^ memoryStatisticsReport
]

{ #category : #accessing }
GtVmStatisticsReport >> printTextualStatisticsOn: aStream [
	aStream	
		<< 'uptime			'.
	self printUpTimeOn:  aStream.
	aStream cr.
	
	self reports do: [ :aReport |
		aReport printTextualStatisticsOn:  aStream ]
]

{ #category : #accessing }
GtVmStatisticsReport >> recordReportStatistics [
	super recordReportStatistics.
	
	self reports do: [ :aReport |
		aReport recordReportStatistics.
		aReport upTime: self upTime ]
]

{ #category : #accessing }
GtVmStatisticsReport >> reports [
	^ { memoryStatisticsReport. gargabeCollectionReport}
]

{ #category : #accessing }
GtVmStatisticsReport >> vmMemorySize [ 
	^ self memoryStatisticsReport memorySize
]
