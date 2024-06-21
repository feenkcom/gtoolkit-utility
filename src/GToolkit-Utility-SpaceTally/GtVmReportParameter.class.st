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
GtVmReportParameter >> formattedParameterValue [
	^ self parameterValue
]

{ #category : #'gt - extensions' }
GtVmReportParameter >> gtViewDescriptionFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Description';
		priority: 10;
		object: [ description ];
		view: #gtStringFor: 
]

{ #category : #'gt - extensions' }
GtVmReportParameter >> gtViewDetailsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Details';
		priority: 1;
		items: [ self parameterDetails ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ] weight: 3;
		send: [ :assoc | assoc value ]
]

{ #category : #'gt - extensions' }
GtVmReportParameter >> gtViewRawValueFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Value';
		priority: 5;
		object: [ self parameterValue printString ];
		view: #gtStringFor: 
]

{ #category : #accessing }
GtVmReportParameter >> parameterDetails [
	^ (self formattedParameterValue ~= self parameterValue printString 
		ifTrue: [{' Formatted Value' -> self formattedParameterValue}] 
		ifFalse: [{}]),
	{
		'Raw Value' -> self parameterValue.
		'Description' -> self description
		}
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
