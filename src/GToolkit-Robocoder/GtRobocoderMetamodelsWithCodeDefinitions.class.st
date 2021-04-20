Class {
	#name : #GtRobocoderMetamodelsWithCodeDefinitions,
	#superclass : #Object,
	#instVars : [
		'viewModelModels',
		'definitions'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> definitions [
	^ definitions
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> definitions: anObject [
	definitions := anObject
]

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> extraAndViewModelCodeDefinitionsDo: aBlock [
	self definitions do: [ :eachViewModelCodeDefinition | eachViewModelCodeDefinition extraDefinitions do: aBlock ].
	self viewModelModelsWithNewCodeDefinitionDo: [ :eachViewModelCodeDefinition | aBlock value: eachViewModelCodeDefinition definition ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodelsWithCodeDefinitions >> generateChanges [
	| theChanges |
	theChanges := RBCompositeRefactoryChange named: 'Generate view models'.
	
	self extraAndViewModelCodeDefinitionsDo: [ :eachGtCodeDefinition |
		theChanges addChange: eachGtCodeDefinition createChange ].
	
	^ theChanges
]

{ #category : #'gt-extensions' }
GtRobocoderMetamodelsWithCodeDefinitions >> gtChangesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Changes';
		priority: 1;
		object: [ self generateChanges ];
		view: #gtChangesFor:
]

{ #category : #'gt-extensions' }
GtRobocoderMetamodelsWithCodeDefinitions >> gtModelsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Models';
		priority: 2;
		items: [ self viewModelModels models ]
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModelWithCodeDefinitionFor: aViewModelModel [
	^ self definitions
		detect: [ :eachViewModelModelWithCodeDefinition | eachViewModelModelWithCodeDefinition metamodel = aViewModelModel ]
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModels [
	^ viewModelModels
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModels: anObject [
	viewModelModels := anObject
]

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModelsWithCodeDefinitionDo: aBlock [
	"Evaluate a given block with each ${class:GtViewModelModelWithCodeDefinition}$"

	self definitions do: aBlock
]

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModelsWithNewCodeDefinitionDo: aBlock [
	"Evaluate a given block with each ${class:GtViewModelModelWithCodeDefinition}$"

	self definitions
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasClass not ]
		thenDo: aBlock
]
