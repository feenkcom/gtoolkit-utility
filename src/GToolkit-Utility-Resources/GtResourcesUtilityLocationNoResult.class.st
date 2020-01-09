"
I represent a negative result. It means that a file or directory does not exist.
See ${class:GtResourcesUtilityLocationResult}$ for more details.

!! Example

${example:GtResourcesUtilityExamples>>#noResult|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtResourcesUtilityLocationNoResult,
	#superclass : #GtResourcesUtilityLocationResult,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #testing }
GtResourcesUtilityLocationNoResult >> exists [
	^ false
]

{ #category : #printing }
GtResourcesUtilityLocationNoResult >> printOn: aStream [
	self file ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Missing ';
		print: self file basename;
		nextPutAll: ' resource'
]
