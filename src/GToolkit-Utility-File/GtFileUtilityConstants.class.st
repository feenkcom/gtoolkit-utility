Class {
	#name : #GtFileUtilityConstants,
	#superclass : #Object,
	#category : 'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileUtilityConstants class >> maxFileNameLenght [
	"Return a maximum file name lenght, excluding extensions and parent directories."
	^ 25
]

{ #category : #accessing }
GtFileUtilityConstants class >> pillarMatchingPattern [
	^ '*.pillar'
]

{ #category : #'accessing - file' }
GtFileUtilityConstants class >> pillarMimeType [
	^ GtFilePillarMimeTypeResolver mimeType
]
