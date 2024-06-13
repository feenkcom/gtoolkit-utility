Class {
	#name : #GtVmReportVmSingleParameter,
	#superclass : #GtVmReportParameter,
	#instVars : [
		'index'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmReportVmSingleParameter class >> leJsonV4Name [

	^ #gtVmReportVmSingleParameter
]

{ #category : #printing }
GtVmReportVmSingleParameter >> descriptionOn: aStream [
	aStream 
		<< '#';
		print: index;
		<< ': '.
	
	super descriptionOn: aStream
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> index [
	^ index
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> index: anInteger [
	index := anInteger
]
