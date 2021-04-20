Class {
	#name : #GtViewModelTypeTestDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelTypeTestDerive class >> label [
	^ 'typeTest'
]

{ #category : #'api - generation' }
GtViewModelTypeTestDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :thisViewModelModelWithCodeDefinition |
		aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :anotherViewModelModelWithCodeDefinition |
			| eachTypeTesterSourceCode |
	
			eachTypeTesterSourceCode := self
				generateViewModelTypeTesterFor: thisViewModelModelWithCodeDefinition viewModelModel
				and: anotherViewModelModelWithCodeDefinition viewModelModel.

			thisViewModelModelWithCodeDefinition definition instanceSideDefinition methods
				addMethod: eachTypeTesterSourceCode
				protocol: 'api - testing' ] ]
]

{ #category : #'private - generation' }
GtViewModelTypeTestDerive >> generateViewModelTypeTesterFor: aViewModelModel and: anotherViewModelModel [
	^ 'is{prefix}{name}{suffix}ViewModel
	"Return true if this is a view model of {name}, false otherwise"
	<return: #Boolean>

	^ {bool}' format: {
			#prefix -> anotherViewModelModel prefix capitalized.
			#name -> anotherViewModelModel name capitalized.
			#suffix -> anotherViewModelModel suffix.
			#bool -> (aViewModelModel = anotherViewModelModel)
		} asDictionary
]
