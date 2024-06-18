Class {
	#name : #GtVmReportCountParameterFormatter,
	#superclass : #GtVmReportParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportCountParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ GtVmReportParametersDiff new 
		markAsDiff;
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (self formatValue: aCurrentValue - aPreviousValue)])
]
