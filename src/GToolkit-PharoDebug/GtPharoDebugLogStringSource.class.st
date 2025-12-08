Class {
	#name : #GtPharoDebugLogStringSource,
	#superclass : #GtPharoDebugLogSource,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #streams }
GtPharoDebugLogStringSource >> readStreamDo: aStream [
	"Read UTF-8 encoded read stream"

	^ string readStreamDo: aStream
]

{ #category : #accessing }
GtPharoDebugLogStringSource >> string [
	^ string
]

{ #category : #accessing }
GtPharoDebugLogStringSource >> string: anObject [
	string := anObject
]
