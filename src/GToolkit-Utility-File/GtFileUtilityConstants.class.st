Class {
	#name : #GtFileUtilityConstants,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #files }
GtFileUtilityConstants class >> localGtDirectory [
	<return: #FileReference>
	^ Smalltalk imageDirectory / self localGtDirectoryName
]

{ #category : #files }
GtFileUtilityConstants class >> localGtDirectoryName [
	^ 'gt-extra'
]

{ #category : #accessing }
GtFileUtilityConstants class >> maxFileNameLenght [
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
