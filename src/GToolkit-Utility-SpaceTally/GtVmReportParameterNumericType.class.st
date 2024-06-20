Class {
	#name : #GtVmReportParameterNumericType,
	#superclass : #GtVmReportParameterType,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterNumericType >> formatValue: aValue [
	^ aValue printString
]
