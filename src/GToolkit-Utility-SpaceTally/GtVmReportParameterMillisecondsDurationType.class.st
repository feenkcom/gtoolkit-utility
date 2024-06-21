Class {
	#name : #GtVmReportParameterMillisecondsDurationType,
	#superclass : #GtVmReportParameterType,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterMillisecondsDurationType >> formatValue: aValue [ 
	^ (Duration milliSeconds: aValue) printString
]
