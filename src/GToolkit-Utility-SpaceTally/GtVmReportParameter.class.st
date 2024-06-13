Class {
	#name : #GtVmReportParameter,
	#superclass : #Object,
	#instVars : [
		'parameterValue',
		'description'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmReportParameter class >> leJsonV4Name [

	^ #gtVmReportParameter
]

{ #category : #accessing }
GtVmReportParameter >> description [
	^ description
]

{ #category : #accessing }
GtVmReportParameter >> description: aDescription [
	description := aDescription
]

{ #category : #printing }
GtVmReportParameter >> descriptionOn: aStream [
	aStream 
		print: parameterValue;
		<< ';';
		print: description
]

{ #category : #accessing }
GtVmReportParameter >> parameterValue [
	^ parameterValue
]

{ #category : #accessing }
GtVmReportParameter >> parameterValue: anObject [
	parameterValue := anObject
]

{ #category : #printing }
GtVmReportParameter >> printOn: aStream [ 
	super printOn: aStream .
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]
