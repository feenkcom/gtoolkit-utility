Class {
	#name : #GtVmReportMicrosecondsDurationParameterFormatter,
	#superclass : #GtVmReportParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportMicrosecondsDurationParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ GtVmReportParametersDiff new 
		markAsDiff;
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (self formatValue: aCurrentValue - aPreviousValue) ])
]

{ #category : #accessing }
GtVmReportMicrosecondsDurationParameterFormatter >> formatValue: aValue [ 
	^ (Duration microSeconds: aValue) printString
]
