Class {
	#name : #GtGarbageCollectsNullRecorder,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #accessing }
GtGarbageCollectsNullRecorder class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
GtGarbageCollectsNullRecorder >> isActive [
	^ false
]

{ #category : #actions }
GtGarbageCollectsNullRecorder >> recordDuring: aBlockDoingGc [
	^ aBlockDoingGc value
]
