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
		| trimmedLine |
		trimmedLine := aLine trimBoth.
		(trimmedLine beginsWith: 'Report STON:')
			ifTrue: [ 
				| newReport |
				newReport := STON fromString: (trimmedLine 
					withoutPrefix: 'Report STON:').
				reports add: newReport ] ].

	^ reports
]
