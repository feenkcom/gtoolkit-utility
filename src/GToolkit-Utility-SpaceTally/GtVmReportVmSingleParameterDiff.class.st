Class {
	#name : #GtVmReportVmSingleParameterDiff,
	#superclass : #Object,
	#instVars : [
		'previousParameter',
		'currentParameter'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> currentParameter [
	^ currentParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> currentParameter: aParameter [
	currentParameter := aParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> description [
	^ self currentParameter description
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> diffFormattedValue [
	^ self parameterSpecification 
		ifNil: [ 
			(GtVmReportParameterSpecification new beGenericFixedValue) 
				formattedDiffFrom: self previousParameter parameterValue
				to: self currentParameter parameterValue ] 
		ifNotNil: [ :aFormatter | 
			aFormatter 
				formattedDiffFrom: self previousParameter parameterValue
				to: self currentParameter parameterValue ]
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> hasChange [
	^ self previousParameter parameterValue ~= self currentParameter parameterValue
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> index [
	^ self currentParameter index
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> label [
	^ self currentParameter label
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> parameterSpecification [
	^ self currentParameter parameterSpecification
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> previousParameter [
	^ previousParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> previousParameter: aParameter [
	previousParameter := aParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> printOn: aStream [

	aStream
		nextPut: $#;
		print: self index;
		<< ': ';
		<< self diffFormattedValue diffDescription;
		<< '; ';
		<< self description.
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> rawDiffValue [
	^self currentParameter parameterValue - self previousParameter parameterValue
]
