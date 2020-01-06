"
I represent a search result which can be either
- positive: ${class:GtResourcesUtilityLocationExistingResult}$, or
- negative: ${class:GtResourcesUtilityLocationNoResult}$.
I am used by ${class:GtResourcesUtilityLocation}$.

My subclasses are created in ${method:GtResourcesUtilityLocation>>#resultForFile:|expanded=true}$.

"
Class {
	#name : #GtResourcesUtilityLocationResult,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-Utility-Resources'
}

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
