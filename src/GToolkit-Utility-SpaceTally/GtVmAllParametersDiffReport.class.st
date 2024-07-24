Class {
	#name : #GtVmAllParametersDiffReport,
	#superclass : #GtVmBasicRuntimeStatisticsDiffReport,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmAllParametersDiffReport class >> leJsonV4Name [

	^ #gtVmAllParametersDiffReport
]

{ #category : #accessing }
GtVmAllParametersDiffReport class >> on: aBlock [
	"Answer an instance of the receiver with statistics gathered on aBlock's execution"
	| report |

	report := self new.
	report sourceReport: GtVmAllParametersReport recordNewReport.
	aBlock value.
	report targetReport: GtVmAllParametersReport recordNewReport.
	^ report.
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> defaultReportClass [
	^ GtVmAllParametersReport
]

{ #category : #'gt - extensions' }
GtVmAllParametersDiffReport >> gtViewChangedParametersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Changed Parameters';
		items: [ self parameterDiffs 
			select: [ :aDiff | aDiff hasChange ] ];
		priority: 10;
		column: 'Index' text: [ :aDiff | aDiff index ] width: 45;
		column: 'Label' text: [ :aDiff | 
			aDiff label ] width: 250;
		column: 'Type' text: [ :aDiff | 
			aDiff diffFormattedValue diffType ] width: 45;
		column: 'Diff/Value' text: [ :aDiff | 
			aDiff diffFormattedValue diffDescription ];
		column: 'Source' text: [ :aDiff | 
			aDiff previousParameter formattedParameterValue ];
		column: 'Target' text: [ :aDiff | 
			aDiff currentParameter formattedParameterValue ];
		column: 'Description' text: [ :aDiff | aDiff description ] weight: 4
]

{ #category : #'gt - extensions' }
GtVmAllParametersDiffReport >> gtViewParametersFullFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Values full';
		items: [ self parameterDiffs ];
		priority: 20;
		column: 'Index' text: [ :aDiff | aDiff index asString ] width: 45;
		column: 'Label' text: [ :aDiff | 
			aDiff label ] width: 250;
		column: 'Type' text: [ :aDiff | 
			aDiff diffFormattedValue diffType ] width: 45;
		column: 'Value' text: [ :aDiff | 
			aDiff diffFormattedValue diffDescription ];
		column: 'Source' text: [ :aDiff | 
			aDiff previousParameter formattedParameterValue ];
		column: 'Target' text: [ :aDiff | 
			aDiff currentParameter formattedParameterValue ];
		column: 'Source (raw)' text: [ :aDiff | 
			aDiff previousParameter parameterValue ] ;
		column: 'Target (raw)' text: [ :aDiff | 
			aDiff currentParameter parameterValue ];
		column: 'Description' text: [ :aDiff | aDiff description ] weight: 2
]

{ #category : #'gt - extensions' }
GtVmAllParametersDiffReport >> gtViewReportsFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Reports';
		priority: 60;
		items: [ {self sourceReport. self targetReport} ];
		column: 'Timestamp' text: [ :aReport | aReport timestamp ];
		column: 'Up Time' text: [ :aReport | aReport upTimeDescription ]
]

{ #category : #'gt - extensions' }
GtVmAllParametersDiffReport >> gtViewSummaryValuesFor: aView [
	
	^ aView columnedList 
		title: 'Values';
		items: [ self parameterDiffs ];
		priority: 15;
		column: 'Index' text: [ :aDiff | aDiff index ] width: 45;
		column: 'Label' text: [ :aDiff | 
			aDiff label ] width: 250;
		column: 'Type' text: [ :aDiff | 
			aDiff diffFormattedValue diffType ] width: 45;
		column: 'Value' text: [ :aDiff | 
			aDiff diffFormattedValue diffDescription ];
		column: 'Source' text: [ :aDiff | 
			aDiff previousParameter formattedParameterValue ];
		column: 'Target' text: [ :aDiff | 
			aDiff currentParameter formattedParameterValue ];
		column: 'Description' text: [ :aDiff | aDiff description ] weight: 4
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> numberOfChangedParameter [
	^ self parameterDiffs 
			count: [ :aDiff | aDiff hasChange ]
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> parameterDiffs [
	^(self sourceReport vmParameters with:
			self targetReport vmParameters 
				collect: [ :aParameter :anotherParameter |
					GtVmReportVmSingleParameterDiff new 
						previousParameter: aParameter;
						currentParameter: anotherParameter])  
]

{ #category : #printing }
GtVmAllParametersDiffReport >> printOn: aStream [
	self hasReports ifFalse: [ 
		^ super printOn: aStream ].
	
	aStream
		print: self numberOfChangedParameter;
		<< ' changed parameters'
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> reportSummaryValues [ 
	^ self parameterDiffs
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> textualDiff [
	^ String streamContents: [ :aStream |
		self textualRepresentationOn:  aStream]
]

{ #category : #printing }
GtVmAllParametersDiffReport >> textualRepresentationForParameter: aParameter on: aStream [ 
	aStream << aParameter formattedParameterValue
]

{ #category : #printing }
GtVmAllParametersDiffReport >> textualRepresentationForParameterDiff: aParameterDiff on: aStream [ 
	aStream 
		<< 'Parameter Index: '
		<< aParameterDiff index printString;
		<< '; label: ';
		<< aParameterDiff label;
		cr.

	aStream
		tab; 
		<< 'Previous value: '.
	self 
		textualRepresentationForParameter: aParameterDiff previousParameter
		on: aStream.
	aStream
		cr;
		tab;
		<< 'Current value: '.
	self 
		textualRepresentationForParameter: aParameterDiff currentParameter
		on: aStream.
]

{ #category : #printing }
GtVmAllParametersDiffReport >> textualRepresentationOn: aStream [
	self parameterDiffs 
		do: [ :aParameterDiff |
			self 
				textualRepresentationForParameterDiff: aParameterDiff
				on: aStream ]
		separatedBy: [ aStream cr; cr ]
]
