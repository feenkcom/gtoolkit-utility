Class {
	#name : #GtVmReportMillisecondsDurationParameterFormatter,
	#superclass : #GtVmReportParameterFormatter,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportMillisecondsDurationParameterFormatter >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ GtVmReportParametersDiff new 
		markAsDiff;
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (self formatValue: aCurrentValue - aPreviousValue) ])
]

{ #category : #accessing }
GtVmReportMillisecondsDurationParameterFormatter >> formatValue: aValue [ 
	^ (Duration milliSeconds: aValue) printString
]
