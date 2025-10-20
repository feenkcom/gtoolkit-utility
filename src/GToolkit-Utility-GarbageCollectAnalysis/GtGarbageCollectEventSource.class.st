Class {
	#name : #GtGarbageCollectEventSource,
	#superclass : #Object,
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #testing }
GtGarbageCollectEventSource >> isBasicNewSource [
	^ false
]

{ #category : #printing }
GtGarbageCollectEventSource >> printOn: aStream [ 
	super printOn: aStream .
	aStream parenthesize: [
		aStream << self sourceDescription ]
]

{ #category : #accessing }
GtGarbageCollectEventSource >> sourceDescription [
	^ self subclassResponsibility
]
