Class {
	#name : #GtVmGarbageCollectionDiffReport,
	#superclass : #GtVmBasicRuntimeStatisticsDiffReport,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmGarbageCollectionDiffReport >> defaultReportClass [
	^ GtVmGarbageCollectionReport
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> fullGCsDiff [

	^ self targetReport fullGCs 
		- self sourceReport fullGCs.
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> fullGcTimeDiff [

	^ self targetReport fullGCTime
		- self sourceReport fullGCTime.
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> incrGCsDiff [

	^ self targetReport incrGCs
		- self sourceReport incrGCs.
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> incrGcTimeDiff [

	^ self targetReport incrGCTime
		- self sourceReport incrGCTime.
]

{ #category : #accessing }
GtVmGarbageCollectionDiffReport >> reportSummaryValues [
	^ {
	'Total GC Time' -> (Duration milliSeconds:  self totalGcTimeDiff).
	'Full GC Time' -> (Duration milliSeconds:  self fullGcTimeDiff).
	'Incremental GC Time' -> (Duration milliSeconds:  self incrGcTimeDiff).
	
	'Full GC Count' -> self fullGCsDiff.
	'Incremental GC Count' -> self incrGCsDiff.
	
	'Average Full GC Time' -> (self fullGCsDiff isZero 
		ifFalse: [(Duration milliSeconds: self fullGcTimeDiff / self fullGCsDiff)]
		ifTrue: [ '-' ]). 
	'Average Incremental GC Time' -> (self incrGCsDiff isZero 
		ifFalse: [(Duration milliSeconds: self incrGcTimeDiff / self incrGCsDiff)]
		ifTrue: [ '-' ])
	}	  
]

{ #category : #'accessing - gc details' }
GtVmGarbageCollectionDiffReport >> totalGcDuration [  
	^ Duration milliSeconds: self totalGcTimeDiff
]

{ #category : #accessing }
GtVmGarbageCollectionDiffReport >> totalGcTimeDiff [ 
	^ self fullGcTimeDiff + self incrGcTimeDiff.
]
