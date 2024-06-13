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
GtVmAllParametersDiffReport >> gtViewParametersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Parameters';
		items: [ (self sourceReport vmParameters with:
			self targetReport vmParameters 
				collect: [ :aParameter :anotherParameter |
					{aParameter . anotherParameter}]) ];
		column: 'Index' text: [ :assoc | assoc first index ] width: 75;
		column: 'Source' text: [ :assoc | 
			assoc first parameterValue ] width: 200;
		column: 'Target' text: [ :assoc | 
			assoc second parameterValue ] width: 200;
		column: 'Description' text: [ :assoc | assoc first description ]
]
