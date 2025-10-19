Class {
	#name : #GtGarbageCollectEventBasicNewSource,
	#superclass : #GtGarbageCollectEventSource,
	#instVars : [
		'requestedSize'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #serialization }
GtGarbageCollectEventBasicNewSource class >> leJsonV4Name [

	^ #gtGarbageCollectEventBasicNewSource
]

{ #category : #testing }
GtGarbageCollectEventBasicNewSource >> isBasicNewSource [
	^ true
]

{ #category : #accessing }
GtGarbageCollectEventBasicNewSource >> requestedSize [
	^ requestedSize
]

{ #category : #accessing }
GtGarbageCollectEventBasicNewSource >> requestedSize: anObject [
	requestedSize := anObject
]

{ #category : #accessing }
GtGarbageCollectEventBasicNewSource >> requestedSizeDescription [
	^ requestedSize
		ifNil: [ '-' ]
		ifNotNil: [ :anInteger | anInteger humanReadableSISizeString ]
]

{ #category : #accessing }
GtGarbageCollectEventBasicNewSource >> sourceDescription [
	^ 'basicNew: ', (requestedSize 
		ifNil: ['<missing>'] 
		ifNotNil: [ :anInteger |
			 self requestedSizeDescription ])
]
