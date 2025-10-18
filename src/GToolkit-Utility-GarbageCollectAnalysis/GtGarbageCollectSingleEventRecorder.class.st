Class {
	#name : #GtGarbageCollectSingleEventRecorder,
	#superclass : #Object,
	#instVars : [
		'newEvent'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #recording }
GtGarbageCollectSingleEventRecorder >> recordGarbageCollectEndWithResult: aResult [
	newEvent largestFreeChunkSize: aResult.
	newEvent recordEndReport.
]

{ #category : #recording }
GtGarbageCollectSingleEventRecorder >> recordGarbageCollectStart [
	newEvent := GtGarbageCollectEvent new.
	newEvent recordStartReport.
]
