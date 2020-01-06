Class {
	#name : #GtResourcesUtilityLocationResult,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #factory }
GtResourcesUtilityLocationResult class >> null [ 
	^ GtResourcesUtilityLocationNoResult new
]

{ #category : #testing }
GtResourcesUtilityLocationResult >> exists [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtResourcesUtilityLocationResult >> file [
	<return: #AbstractFileReference>
	^ file
]

{ #category : #accessing }
GtResourcesUtilityLocationResult >> file: anAbstractFileReference [
	"The file reference must exist.
	We do not test it here as testing might be time consuming."
	file := anAbstractFileReference
]
