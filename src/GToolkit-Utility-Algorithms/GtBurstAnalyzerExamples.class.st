Class {
	#name : #GtBurstAnalyzerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Algorithms-Bursts - Examples'
}

{ #category : #accessing }
GtBurstAnalyzerExamples >> burstAnalyzerWithCustomCutoff [
	<gtExample>
	| analyzer |
	analyzer := self simpleBurstAnalyzer cutoff: 30.
	
	self assert: analyzer run size equals: 2.

	^ analyzer
]

{ #category : #accessing }
GtBurstAnalyzerExamples >> simpleBurstAnalyzer [
	<gtExample>
	| analyzer |
	analyzer := GtBurstAnalyzer new timeSeries: self timeSeries.
	
	self assert: analyzer run size equals: 1.

	^ analyzer
]

{ #category : #accessing }
GtBurstAnalyzerExamples >> timeSeries [
	<gtExample>
	^ {1.
		2.
		3.
		4.
		50.
		55.
		5.
		3.
		6.
		4.
		9.
		10.
		70.
		50.
		3.
		5.
		2.
		4.
		3.
		9.
		8}
]
