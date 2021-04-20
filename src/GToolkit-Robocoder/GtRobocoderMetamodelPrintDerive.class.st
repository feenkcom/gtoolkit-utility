Class {
	#name : #GtRobocoderMetamodelPrintDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelPrintDerive class >> label [
	^ 'print'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelPrintDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		self generatePrintOnMethodFor: eachViewModelModelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelPrintDerive >> generatePrintOnMethodFor: aViewModelModelWithCodeDefinition [
	| aMethodSource |
aMethodSource :=
'printOn: aStream
	aStream
		print: self {modelGetter}'
			format: {
				#modelGetter -> aViewModelModelWithCodeDefinition modelGetterSelector
			} asDictionary.

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: aMethodSource
		protocol: 'printing'
]
