Class {
	#name : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#superclass : #GtRobocoderMetamodelWithPropertyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #testing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithChoicePropertyFromManyDerive
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenOfOneMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyUnsetChildren:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenOfOneSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyUnsetChildrenOfOneMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnsetChildrenOfOneMethodFor: aMetamodelWithCodeDefinition [
	| aMethodDefinition theChildrenForMany |

	self
		assert: [ aMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only metamodel for one can implement child specific selection methods' ].
	
	theChildrenForMany := (aMetamodelWithCodeDefinition children select: #isForMany)
		ifEmpty: [ ^ self ].

	aMethodDefinition := (self propertyUnsetOthersMethodOfOne: aMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	theChildrenForMany do: [ :eachMetamodelWithCodeDefinition |
		| eachSourceCode |		
		eachSourceCode := GtRobocoderTemplateMethodCoder new
			doNotEmbedGeneratedFromPragma;
			forMethod: GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> #unsetChildrenTemplate;
			mappings: {
				#childrenGetter -> (GtRobocoderMetamodelChildrenDerive
					childObjectGetterSelectorIn: aMetamodelWithCodeDefinition childMetamodel: eachMetamodelWithCodeDefinition).
				#propertyUnsetter -> (self propertyUnsetterSelectorOf: eachMetamodelWithCodeDefinition) };
			translate.

		aMethodDefinition
			addMethodPartSource: eachSourceCode
			id: eachMetamodelWithCodeDefinition name ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertySetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersMethodOfOne: aGtRobocoderMetamodelWithCodeDefinition [
	self
		assert: [ aGtRobocoderMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].
		
	^ self class
		propertyUnsetChildrenOfOneMethodIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{childrenGetter}} {{propertyUnsetter}}.';
		protocol: 'api - converting';
		storageMethod: thisContext method
]
