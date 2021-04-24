Class {
	#name : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#superclass : #GtRobocoderMetamodelWithPropertyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #testing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithChoicePropertyFromManyDerive
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
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition) selector
]
