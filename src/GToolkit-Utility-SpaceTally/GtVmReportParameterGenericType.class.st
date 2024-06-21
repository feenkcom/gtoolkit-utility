Class {
	#name : #GtVmReportParameterGenericType,
	#superclass : #GtVmReportParameterType,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterGenericType >> formatValue: aValue [
	^ aValue printString
]
