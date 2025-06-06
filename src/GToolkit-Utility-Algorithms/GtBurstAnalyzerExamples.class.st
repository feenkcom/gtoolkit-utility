Class {
	#name : #GtBurstAnalyzerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Algorithms-Bursts - Examples'
}

{ #category : #accessing }
GtBurstAnalyzerExamples >> burstAnalyzerWithCustomCutoff [
	<gtExample>
	<return: #GtBurstAnalyzer>
	| analyzer runs |
	analyzer := self simpleBurstAnalyzer cutoff: 30.
	runs := analyzer run.

	self assert: runs size equals: 2.
	self assert: runs first equals: (5 to: 6).

	^ analyzer
]

{ #category : #accessing }
GtBurstAnalyzerExamples >> simpleBurstAnalyzer [
	<gtExample>
	<return: #GtBurstAnalyzer>
	| analyzer runs |
	analyzer := GtBurstAnalyzer new timeSeries: self timeSeries.
	runs := analyzer run.

	self assert: runs size equals: 1.
	self assert: runs first equals: (13 to: 13).

	^ analyzer
]

{ #category : #accessing }
GtBurstAnalyzerExamples >> timeSeries [
	<gtExample>
	<return: #Array>
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
