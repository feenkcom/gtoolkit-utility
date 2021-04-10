"
! View model api Trait derive
Generates an api trait for each view model that helps users to bind the view model to a UI element.
The generation happens based on the ${class:TGtWithViewModelTraitTemplate}$ using ${class:GtWithViewModelTraitGenerator}$
"
Class {
	#name : #GtViewModelApiTraitDerive,
	#superclass : #GtViewModelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelApiTraitDerive class >> label [
	^ 'api'
]

{ #category : #'api - generation' }
GtViewModelApiTraitDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| anApiTraitDefinition |
		
		anApiTraitDefinition := self generateViewModelApiTraitFor: eachViewModelModelWithCodeDefinition viewModelModel.
		eachViewModelModelWithCodeDefinition addExtraDefinition: anApiTraitDefinition ]
]

{ #category : #'private - generation' }
GtViewModelApiTraitDerive >> generateViewModelApiTraitFor: aViewModelModel [
	^ GtWithViewModelTraitGenerator new
		modelName: aViewModelModel prefix uncapitalized, aViewModelModel name capitalized, aViewModelModel suffix capitalized;
		projectPrefix: aViewModelModel project;
		packageName: aViewModelModel package;
		generateBehaviorDefinition
]
