Class {
	#name : #GtViewModelPrintDerive,
	#superclass : #GtViewModelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelPrintDerive class >> label [
	^ 'print'
]

{ #category : #'api - generation' }
GtViewModelPrintDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		self generatePrintOnMethodFor: eachViewModelModelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtViewModelPrintDerive >> generatePrintOnMethodFor: aViewModelModelWithCodeDefinition [
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