Extension { #name : #BenchmarkComparison }

{ #category : #'*GToolkit-Utility-System' }
BenchmarkComparison >> gtSummaryFor: aView [
	<gtView>

	^(aView columnedList)
		title: 'Summary';
		priority: 10;
		items: [ self summaryAttributes ];
		column: #Attribute text: [:item | item first];
		column: #Value text: [:item | item second];
		send: #last;
		actionUpdateButton
]

{ #category : #'*GToolkit-Utility-System' }
BenchmarkComparison >> summaryAttributes [

	^ {
		{ 'Comparison / Reference'. (comparisonResult period / referenceResult period) asFloat. }.
		}
]
