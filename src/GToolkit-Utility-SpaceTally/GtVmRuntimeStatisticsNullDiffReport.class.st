Class {
	#name : #GtVmRuntimeStatisticsNullDiffReport,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmRuntimeStatisticsNullDiffReport class >> leJsonV4Name [

	^ #gtVmStatisticsReportsNullDiff
]

{ #category : #profiling }
GtVmRuntimeStatisticsNullDiffReport >> recordSourceReport [
	"Do nothing"
]

{ #category : #profiling }
GtVmRuntimeStatisticsNullDiffReport >> recordTargetReport [
	"Do nothing"
]
