Class {
	#name : #GtRobocoderMetamodelAsElementDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive class >> label [
	^ 'asElement'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelAsElementDerive >> applyOnMetamodelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		| eachNameMethodSourceCode |

		

		eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
			forMethod: self class >> #asElementTemplate;
			mappings: { #elementClass -> BlElement . #viewModelSetter -> eachViewModelModelWithCodeDefinition }.

		

		"eachNameMethodSourceCode := self
			generateViewModelNameMethodFor: eachViewModelModelWithCodeDefinition viewModelModel.

		eachViewModelModelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing'" ]
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> asElementTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'asElement
	^ {{elementClass}} new
		{{viewModelSetter}}: self';
		protocol: 'api - converting';
		storageMethod: thisContext method
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> name: anObject [
	name := anObject
]
