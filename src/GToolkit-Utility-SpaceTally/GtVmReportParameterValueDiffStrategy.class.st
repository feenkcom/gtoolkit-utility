Class {
	#name : #GtVmReportParameterValueDiffStrategy,
	#superclass : #GtVmReportParameterDiffStrategy,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterValueDiffStrategy >> formattedDiffFrom: aPreviousValue to: aCurrentValue forType: aValueType [
	aPreviousValue = aCurrentValue ifFalse: [
		GtVmReportParametersDiff new 
			diffDescription: (String streamContents: [ :aStream |
				aStream 
					<< (aValueType formatValue: aPreviousValue);
					<< ' | ';
					<< (aValueType formatValue: aCurrentValue) ])].
	
	^ GtVmReportParametersDiff new 
		diffDescription: (String streamContents: [ :aStream |
			aStream 
				<< (aValueType formatValue: aCurrentValue) ])
]
