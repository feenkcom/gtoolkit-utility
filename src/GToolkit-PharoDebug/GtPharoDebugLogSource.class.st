Class {
	#name : #GtPharoDebugLogSource,
	#superclass : #Object,
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #streams }
GtPharoDebugLogSource >> readStreamDo: aStream [
	"Read UTF-8 encoded read stream"

	^ self subclassResponsibility
]
