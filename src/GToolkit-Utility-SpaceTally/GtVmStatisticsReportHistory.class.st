Class {
	#name : #GtVmStatisticsReportHistory,
	#superclass : #Object,
	#instVars : [
		'statisticReports'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtVmStatisticsReportHistory >> addReport: aReport [
	self statisticReports add: aReport
]

{ #category : #'gt - extensions' }
GtVmStatisticsReportHistory >> gtViewReportsFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Reports';
		items: [ self statisticReports ];
		column: 'Timestamp' text: [ :aReport | aReport timestamp ];
		column: 'Up Time' text: [ :aReport | aReport upTimeDescription ];
		column: 'VM Memory' text: [ :aReport | 
			aReport vmMemorySize humanReadableIsqByteSize ]
]

{ #category : #initialization }
GtVmStatisticsReportHistory >> initialize [ 
	super initialize.
	
	statisticReports := OrderedCollection new.
]

{ #category : #accessing }
GtVmStatisticsReportHistory >> statisticReports [
	^ statisticReports
]
