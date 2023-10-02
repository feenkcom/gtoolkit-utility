Class {
	#name : #GtVmExecutionStatisticsReportLogLoader,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmExecutionStatisticsReportLogLoader class >> readFromString: aLogContentString [
	^ self new 
		loadReportsFromLogContent: aLogContentString
]

{ #category : #accessing }
GtVmExecutionStatisticsReportLogLoader >> loadReportsFromLogContent: aLogContentString [
	| reports |
	reports := GtVmExecutionStatisticsReportsGroup new.
	
	aLogContentString linesDo: [ :aLine |
		(aLine beginsWith: 'Report STON:')
			ifTrue: [ 
				| newReport |
				newReport := STON fromString: (aLine 
					withoutPrefix: 'Report STON:').
				reports add: newReport ] ].

	^ reports
]
