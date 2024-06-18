Class {
	#name : #GtVmReportParameterFormatter,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterFormatter >> formatValue: aValue [
	^ aValue printString
]

{ #category : #accessing }
GtVmReportParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ GtVmReportParametersDiff new 
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (self formatValue: aPreviousValue);
				<< ' | ';
				<< (self formatValue: aCurrentValue) ])
]
