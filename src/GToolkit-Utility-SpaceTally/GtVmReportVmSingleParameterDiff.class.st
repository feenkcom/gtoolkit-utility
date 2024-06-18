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
	^ self parameterFormater 
		ifNil: [ 
			GtVmReportFixedParameterFormatter new 
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
GtVmReportVmSingleParameterDiff >> parameterFormater [
	^ self currentParameter parameterFormater
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> previousParameter [
	^ previousParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameterDiff >> previousParameter: aParameter [
	previousParameter := aParameter
]
