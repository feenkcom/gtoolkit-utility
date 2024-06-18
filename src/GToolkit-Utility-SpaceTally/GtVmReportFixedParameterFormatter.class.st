Class {
	#name : #GtVmReportFixedParameterFormatter,
	#superclass : #GtVmReportParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportFixedParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	aPreviousValue = aCurrentValue ifFalse: [
	^ super formattedDiffFrom: aPreviousValue to: aCurrentValue].
	
	^ GtVmReportParametersDiff new 
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (self formatValue: aCurrentValue) ])
]
