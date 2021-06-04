"
I represent a positive result. It means that a file or directory exists.
See {{gtClass:GtResourcesUtilityLocationResult}} for more details.

1. # Example


{{gtExample:GtResourcesUtilityExamples>>#existingResult|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtResourcesUtilityLocationExistingResult,
	#superclass : #GtResourcesUtilityLocationResult,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #testing }
GtResourcesUtilityLocationExistingResult >> exists [
	^ true
]

{ #category : #printing }
GtResourcesUtilityLocationExistingResult >> printOn: aStream [
	self file ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Existing ';
		print: self file basename;
		nextPutAll: ' resource'
]
