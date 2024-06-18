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
GtVmAllParametersDiffReport >> defaultReportClass [
	^ GtVmAllParametersReport
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> gtViewChangedParametersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Changed Parameters';
		items: [ self parameterDiffs 
			select: [ :aDiff | aDiff hasChange ] ];
		priority: 10;
		column: 'Index' text: [ :aDiff | aDiff index ] width: 45;
		column: 'Type' text: [ :aDiff | 
			aDiff diffFormattedValue diffType ] width: 45;
		column: 'VaDiff/Value' text: [ :aDiff | 
			aDiff diffFormattedValue diffDescription ];
		column: 'Source' text: [ :aDiff | 
			aDiff previousParameter formattedParameterValue ];
		column: 'Target' text: [ :aDiff | 
			aDiff currentParameter formattedParameterValue ];
		column: 'Description' text: [ :aDiff | aDiff description ] weight: 4
]

{ #category : #accessing }
GtVmAllParametersDiffReport >> gtViewParametersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Parameters';
		items: [ self parameterDiffs ];
		column: 'Index' text: [ :aDiff | aDiff index ] width: 45;
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
GtVmAllParametersDiffReport >> gtViewParametersFullFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Parameters full';
		items: [ self parameterDiffs ];
		priority: 55;
		column: 'Index' text: [ :aDiff | aDiff index ] width: 75;
		column: 'Source' text: [ :aDiff | 
			aDiff previousParameter parameterValue ] width: 200;
		column: 'Target' text: [ :aDiff | 
			aDiff currentParameter parameterValue ] width: 200;
		column: 'Description' text: [ :aDiff | aDiff description ]
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
