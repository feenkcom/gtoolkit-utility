Class {
	#name : #GtViewModelNameDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelNameDerive class >> label [
	^ 'name'
]

{ #category : #'api - generation' }
GtViewModelNameDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| eachNameMethodSourceCode |

		eachNameMethodSourceCode := self
			generateViewModelNameMethodFor: eachViewModelModelWithCodeDefinition viewModelModel.

		eachViewModelModelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing' ]
]

{ #category : #'private - generation' }
GtViewModelNameDerive >> generateViewModelNameMethodFor: aViewModelModel [
	^ 'viewModelName
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ {name}' format: {
			#name -> aViewModelModel name asSymbol printString.
		} asDictionary
]
