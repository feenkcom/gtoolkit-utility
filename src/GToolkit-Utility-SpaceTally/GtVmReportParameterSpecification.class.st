Class {
	#name : #GtVmReportParameterSpecification,
	#superclass : #Object,
	#instVars : [
		'label',
		'parameterType',
		'diffStrategy'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterSpecification class >> labeled: aString [
	^ self new 
		label: aString
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beGenericFixedValue [
	self withGenericType.
	self withValueDiff
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beMemoryComparableConfig [
	self withMemoryBytesType.
	self withComparableDiff.
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beMemoryFixedValue [
	self withMemoryBytesType.
	self withValueDiff
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beMicrosecondsDurationComparableConfig [
	self withMicrosecondsDurationType.
	self withComparableDiff.
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beMillisecondsDurationComparableConfig [
	self withMillisecondsDurationType.
	self withComparableDiff.
]

{ #category : #accessing }
GtVmReportParameterSpecification >> beNumericalComparableConfig [
	self withNumericType.
	self withComparableDiff.
]

{ #category : #accessing }
GtVmReportParameterSpecification >> formatValue: aValue [
	^ self parameterType formatValue:  aValue
]

{ #category : #accessing }
GtVmReportParameterSpecification >> formattedDiffFrom: aPreviousValue to: aCurrentValue [
	^ diffStrategy 
		formattedDiffFrom: aPreviousValue 
		to: aCurrentValue 
		forType: self
]

{ #category : #accessing }
GtVmReportParameterSpecification >> label [
	^ label
]

{ #category : #accessing }
GtVmReportParameterSpecification >> label: aString [ 
	label := aString 
]

{ #category : #accessing }
GtVmReportParameterSpecification >> parameterType [
	^ parameterType
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withComparableDiff [
	diffStrategy := GtVmReportParameterComparableDiffStrategy new
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withGenericType [
	parameterType := GtVmReportParameterGenericType new.
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withMemoryBytesType [
	parameterType := GtVmReportParameterMemoryBytesType new
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withMicrosecondsDurationType [
	parameterType := GtVmReportParameterMicrosecondsType new
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withMillisecondsDurationType [
	parameterType := GtVmReportParameterMillisecondsDurationType new
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withNumericType [
	parameterType := GtVmReportParameterNumericType new
]

{ #category : #configuring }
GtVmReportParameterSpecification >> withValueDiff [
	diffStrategy := GtVmReportParameterValueDiffStrategy new
]
