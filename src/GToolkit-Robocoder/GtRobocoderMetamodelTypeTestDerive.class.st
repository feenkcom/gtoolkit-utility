Class {
	#name : #GtRobocoderMetamodelTypeTestDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelTypeTestDerive class >> label [
	^ 'typeTest'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelTypeTestDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :thisViewModelModelWithCodeDefinition |
		aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :anotherViewModelModelWithCodeDefinition |
			| eachTypeTesterSourceCode |
	
			eachTypeTesterSourceCode := self
				generateViewModelTypeTesterFor: thisViewModelModelWithCodeDefinition metamodel
				and: anotherViewModelModelWithCodeDefinition metamodel.

			thisViewModelModelWithCodeDefinition definition instanceSideDefinition methods
				addMethod: eachTypeTesterSourceCode
				protocol: 'api - testing' ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelTypeTestDerive >> generateViewModelTypeTesterFor: aViewModelModel and: anotherViewModelModel [
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
