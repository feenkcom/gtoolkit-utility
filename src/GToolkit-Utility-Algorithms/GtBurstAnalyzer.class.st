Class {
	#name : #GtBurstAnalyzer,
	#superclass : #Object,
	#instVars : [
		'timeSeries',
		'cutoff'
	],
	#category : #'GToolkit-Utility-Algorithms-Bursts'
}

{ #category : #accessing }
GtBurstAnalyzer >> cutoff [
	^ cutoff
]

{ #category : #accessing }
GtBurstAnalyzer >> cutoff: anObject [
	cutoff := anObject
]

{ #category : #accessing }
GtBurstAnalyzer >> ensureCutoff [
	"default cutoff is double the standard deviation"
	self cutoff ifNil: [
		cutoff := timeSeries stdev * 2
	]
]

{ #category : #accessing }
GtBurstAnalyzer >> gtViewBurstIntervalsFor: aView [
	<gtView>
	^ aView list
		title: 'Burst intervals';
		priority: 2;
		items: [ self run ]
]

{ #category : #accessing }
GtBurstAnalyzer >> gtViewBurstsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Bursts';
		priority: 1;
		stencil: [ | data maxLines scale chart outliers |
			data := GtPlotterDataGroup new
					values: (timeSeries collectWithIndex: [ :value :i | i -> value ]).
			outliers := self run.
			data := data
					colored: [ :each | 
						(outliers anySatisfy: [ :anInterval | anInterval includes: each key ])
							ifTrue: [ Color black ]
							ifFalse: [ Color veryLightGray ] ].

			maxLines := timeSeries max.
			scale := GtPlotterLinearScale new domainFrom: 0 to: maxLines.

			chart := GtPlotterVerticalBarChart new.
			chart
				barElement: [ :aGtPlotterContext | 
					BlElement new
						aptitude: (BrGlamorousWithTooltipAptitude
								content: [ BrLabel new
										text: aGtPlotterContext originalValue value;
										aptitude: (BrGlamorousLabelAptitude new padding: (BlInsets all: 1)) ]) ].
			chart barHeightScale: scale.
			chart barWidthScale constant: 20.
			chart barHeightData: [ :eachValue | eachValue value ].
			chart amountOfTicks: 10.
			chart with: data]
]

{ #category : #accessing }
GtBurstAnalyzer >> run [
	| average bursts idx upperBound lowerBound |
	average := timeSeries average.
	bursts := OrderedCollection new.
	idx := 1.
	self ensureCutoff.
	upperBound := average + cutoff.
	lowerBound := average - cutoff.

	[ idx < timeSeries size ]
		whileTrue: [ | value startIdx |
			value := timeSeries at: idx.
			startIdx := idx.
			[ (value > upperBound or: [ value < lowerBound ])
				and: [ idx < timeSeries size ] ]
				whileTrue: [ idx := idx + 1.

					value := timeSeries at: idx ].

			idx > startIdx ifTrue: [ bursts add: (startIdx to: idx) ].

			idx := idx + 1 ].

	^ bursts
]

{ #category : #accessing }
GtBurstAnalyzer >> timeSeries [
	^ timeSeries
]

{ #category : #accessing }
GtBurstAnalyzer >> timeSeries: anObject [
	timeSeries := anObject
]
