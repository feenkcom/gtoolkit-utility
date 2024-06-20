Class {
	#name : #GtVmReportParameterComparableDiffStrategy,
	#superclass : #GtVmReportParameterDiffStrategy,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterComparableDiffStrategy >> formattedDiffFrom: aPreviousValue to: aCurrentValue forType: aValueType [
	^ GtVmReportParametersDiff new 
		markAsDiff;
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (aValueType formatValue: aCurrentValue - aPreviousValue) ])
]
