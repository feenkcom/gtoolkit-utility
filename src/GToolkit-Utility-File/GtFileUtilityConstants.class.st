Class {
	#name : #GtFileUtilityConstants,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileUtilityConstants class >> maxFileNameLength [
	"Return a maximum file name lenght, excluding extensions and parent directories."
	^ 25
]

{ #category : #'accessing - file' }
GtFileUtilityConstants class >> pillarExtension [
	^ GtFilePillarMimeTypeResolver supportedExtensions first 
]

{ #category : #accessing }
GtFileUtilityConstants class >> pillarMatchingPattern [
	^ '*.pillar'
]

{ #category : #'accessing - file' }
GtFileUtilityConstants class >> pillarMimeType [
	^ GtFilePillarMimeTypeResolver mimeType
]
