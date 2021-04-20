"
! View model api Trait derive
Generates an api trait for each view model that helps users to bind the view model to a UI element.
The generation happens based on the ${class:TGtWithViewModelTraitTemplate}$ using ${class:GtWithViewModelTraitGenerator}$
"
Class {
	#name : #GtRobocoderMetamodelApiTraitDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelApiTraitDerive class >> label [
	^ 'api'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelApiTraitDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| anApiTraitDefinition |
		
		anApiTraitDefinition := self generateMetamodelApiTraitFor: eachViewModelModelWithCodeDefinition viewModelModel.
		eachViewModelModelWithCodeDefinition addExtraDefinition: anApiTraitDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelApiTraitDerive >> generateMetamodelApiTraitFor: aViewModelModel [
	^ GtRobocoderWithObjectTraitGenerator new
		modelName: (aViewModelModel prefix uncapitalized, aViewModelModel name capitalized, aViewModelModel suffix capitalized) uncapitalized;
		projectPrefix: aViewModelModel project;
		packageName: aViewModelModel package;
		tagName: aViewModelModel fullTagForTraits;
		generateBehaviorDefinition
]
