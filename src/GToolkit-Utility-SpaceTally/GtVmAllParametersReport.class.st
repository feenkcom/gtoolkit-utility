Class {
	#name : #GtVmAllParametersReport,
	#superclass : #GtVmBasicResourceRuntimeReport,
	#instVars : [
		'vmParameters',
		'extraParameters'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmAllParametersReport class >> leJsonV4Name [

	^ #gtVmAllParametersReport
]

{ #category : #accessing }
GtVmAllParametersReport >> ephemeronsListSize [
	^ self extraParameters 
		at: #ephemeronsListSize 
		ifPresent: [ :aParameter | aParameter parameterValue ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtVmAllParametersReport >> ephemeronsListSize: anInteger [
	self extraParameters 
		at: #ephemeronsListSize 
		put: (GtVmReportParameter new
			parameterValue: anInteger;
			description: 'The size of the ephemerons list')
]

{ #category : #accessing }
GtVmAllParametersReport >> extraParameters [
	^ extraParameters ifNil: [
		extraParameters := Dictionary new]
]

{ #category : #accessing }
GtVmAllParametersReport >> extraParameters: aDictionary [
	extraParameters := aDictionary
]

{ #category : #accessing }
GtVmAllParametersReport >> gtViewVmParametersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Parameters';
		items: [ vmParameters ];
		column: 'Index' text: [ :aVmParameter | aVmParameter index ] width: 75;
		column: 'Formatted value' text: [ :aVmParameter | 
			aVmParameter formattedParameterValue ] width: 200;
		column: 'Raw value' text: [ :aVmParameter | aVmParameter parameterValue ] width: 200;
		column: 'Description' text: [ :aVmParameter | aVmParameter description ]
]

{ #category : #accessing }
GtVmAllParametersReport >> recordReportStatistics [
	| currentParameters |
	
	super recordReportStatistics.
	currentParameters := Smalltalk vm getParameters.
	
	vmParameters := Smalltalk vm parameterLabels 
		pairsCollect: [:anIndex :aDescription |
			GtVmReportVmSingleParameter new 
				index: anIndex;
				description: aDescription;
				parameterValue: (currentParameters at: anIndex) ].
				
	self ephemeronsListSize: FinalizationRegistry default size .
]

{ #category : #accessing }
GtVmAllParametersReport >> vmParameters [
	^ vmParameters
]

{ #category : #accessing }
GtVmAllParametersReport >> vmParameters: aCollection [
	vmParameters := aCollection
]
