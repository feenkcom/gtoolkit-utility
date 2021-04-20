Class {
	#name : #GtRobocoderMetamodelNameDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelNameDerive class >> label [
	^ 'name'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelNameDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| eachNameMethodSourceCode |

		eachNameMethodSourceCode := self
			generateViewModelNameMethodFor: eachViewModelModelWithCodeDefinition metamodel.

		eachViewModelModelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing' ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelNameDerive >> generateViewModelNameMethodFor: aViewModelModel [
	^ 'viewModelName
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ {name}' format: {
			#name -> aViewModelModel name asSymbol printString.
		} asDictionary
]
