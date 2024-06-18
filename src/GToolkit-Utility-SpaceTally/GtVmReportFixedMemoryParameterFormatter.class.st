Class {
	#name : #GtVmReportFixedMemoryParameterFormatter,
	#superclass : #GtVmReportFixedParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportFixedMemoryParameterFormatter >> formatValue: aValue [ 
	^ aValue humanReadableSISizeString
]
