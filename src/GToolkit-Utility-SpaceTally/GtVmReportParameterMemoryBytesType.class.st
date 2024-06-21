Class {
	#name : #GtVmReportParameterMemoryBytesType,
	#superclass : #GtVmReportParameterType,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterMemoryBytesType >> formatValue: aValue [ 
	^ String streamContents: [ :aStream |
		aValue < 0 ifTrue: [
			aStream << '-'].
		aStream << aValue abs humanReadableSISizeString ]
]
