Class {
	#name : #GtVmReportParametersDiff,
	#superclass : #Object,
	#instVars : [
		'diffDescription',
		'diffType'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParametersDiff >> diffDescription [
	^ diffDescription
]

{ #category : #accessing }
GtVmReportParametersDiff >> diffDescription: aString [ 
	diffDescription := aString 
]

{ #category : #accessing }
GtVmReportParametersDiff >> diffType [
	^ diffType ifNil: [ #value ]
]

{ #category : #accessing }
GtVmReportParametersDiff >> diffType: anObject [
	diffType := anObject
]

{ #category : #accessing }
GtVmReportParametersDiff >> markAsDiff [
	self diffType: #diff
]
