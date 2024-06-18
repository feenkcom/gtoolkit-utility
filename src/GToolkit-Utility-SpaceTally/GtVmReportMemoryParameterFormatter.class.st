Class {
	#name : #GtVmReportMemoryParameterFormatter,
	#superclass : #GtVmReportParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportMemoryParameterFormatter >> formatValue: aValue [ 
	^ aValue humanReadableSISizeString
]

{ #category : #accessing }
GtVmReportMemoryParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ GtVmReportParametersDiff new 
		markAsDiff;
		diffDescription: (String streamContents: [ :aStream |
			| difference  |
			difference := aCurrentValue - aPreviousValue.
			difference < 0 ifTrue: [
				aStream << '-'].
			aStream << (self formatValue: difference abs)])
]
