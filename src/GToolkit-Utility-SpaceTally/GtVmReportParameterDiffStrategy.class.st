Class {
	#name : #GtVmReportParameterDiffStrategy,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmReportParameterDiffStrategy >> formattedDiffFrom: aPreviousValue to: aCurrentValue forType: aValueType [
	^ self subclassResponsibility
]
