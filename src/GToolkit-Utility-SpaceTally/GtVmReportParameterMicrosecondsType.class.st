Class {
	#name : #GtVmReportParameterMicrosecondsType,
	#superclass : #GtVmReportParameterType,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterMicrosecondsType >> formatValue: aValue [ 
	^ (Duration microSeconds: aValue) printString
]
