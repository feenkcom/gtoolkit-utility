Class {
	#name : #GtViewModelAsElementDerive,
	#superclass : #GtViewModelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelAsElementDerive class >> label [
	^ 'asElement'
]

{ #category : #'api - generation' }
GtViewModelAsElementDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| eachNameMethodSourceCode |
		
		GtPharoTemplateMethodCoder new
			forCompiledMethod: self class >> #asElementTemplate;
			mappings: { #elementClass -> BlElement . #viewModelSetter -> eachViewModelModelWithCodeDefinition }.

		"eachNameMethodSourceCode := self
			generateViewModelNameMethodFor: eachViewModelModelWithCodeDefinition viewModelModel.

		eachViewModelModelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing'" ]
]

{ #category : #accessing }
GtViewModelAsElementDerive >> asElementTemplate [
	<gtMethodTemplate>
"asElement
	^ {{elementClass}} new
		{{viewModelSetter}}: self"
]

{ #category : #accessing }
GtViewModelAsElementDerive >> name [
	^ name
]

{ #category : #accessing }
GtViewModelAsElementDerive >> name: anObject [
	name := anObject
]
