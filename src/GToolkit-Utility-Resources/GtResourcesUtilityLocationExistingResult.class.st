"
I represent a positive result. It means that a file or directory exists.
See ${class:GtResourcesUtilityLocationResult}$ for more details.

!! Example

${example:GtResourcesUtilityExamples>>#existingResult|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtResourcesUtilityLocationExistingResult,
	#superclass : #GtResourcesUtilityLocationResult,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #testing }
GtResourcesUtilityLocationExistingResult >> exists [
	^ true
]
