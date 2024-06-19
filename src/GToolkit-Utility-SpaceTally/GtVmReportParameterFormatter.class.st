Class {
	#name : #GtVmReportParameterFormatter,
	#superclass : #Object,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterFormatter class >> labeled: aString [
	^ self new 
		label: aString
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

{ #category : #accessing }
GtVmReportParameterFormatter >> formatValue: aValue [
	^ aValue printString
]

{ #category : #accessing }
GtVmReportParameterFormatter >> label [
	^ label
]

{ #category : #accessing }
GtVmReportParameterFormatter >> label: aString [ 
	label := aString 
]
