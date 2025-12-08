Class {
	#name : #GtPharoDebugLogFileSource,
	#superclass : #GtPharoDebugLogSource,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #accessing }
GtPharoDebugLogFileSource >> file [
	^ file
]

{ #category : #accessing }
GtPharoDebugLogFileSource >> file: aFileReference [
	file := aFileReference
]

{ #category : #streams }
GtPharoDebugLogFileSource >> readStreamDo: aStream [
	"Read UTF-8 encoded read stream"

	^ file asFileReference readStreamDo: aStream
]
