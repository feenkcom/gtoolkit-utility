Class {
	#name : #GtViewModelModelsWithCodeDefinitions,
	#superclass : #Object,
	#instVars : [
		'viewModelModels',
		'definitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #accessing }
GtViewModelModelsWithCodeDefinitions >> definitions [
	^ definitions
]

{ #category : #accessing }
GtViewModelModelsWithCodeDefinitions >> definitions: anObject [
	definitions := anObject
]

{ #category : #enumerating }
GtViewModelModelsWithCodeDefinitions >> extraAndViewModelCodeDefinitionsDo: aBlock [
	self definitions do: [ :eachViewModelCodeDefinition | eachViewModelCodeDefinition extraDefinitions do: aBlock ].
	self definitions do: [ :eachViewModelCodeDefinition | aBlock value: eachViewModelCodeDefinition definition ]
]

{ #category : #'api - generation' }
GtViewModelModelsWithCodeDefinitions >> generateChanges [
	| theChanges |
	theChanges := RBCompositeRefactoryChange named: 'Generate view models'.
	
	self extraAndViewModelCodeDefinitionsDo: [ :eachGtCodeDefinition |
		theChanges addChange: eachGtCodeDefinition createChange ].
	
	^ theChanges
]

{ #category : #'gt-extensions' }
GtViewModelModelsWithCodeDefinitions >> gtChangesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Changes';
		priority: 1;
		object: [ self generateChanges ];
		view: #gtChangesFor:
]

{ #category : #'gt-extensions' }
GtViewModelModelsWithCodeDefinitions >> gtModelsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Models';
		priority: 2;
		items: [ self viewModelModels models ]
]

{ #category : #accessing }
GtViewModelModelsWithCodeDefinitions >> viewModelModelWithCodeDefinitionFor: aViewModelModel [
	^ self definitions
		detect: [ :eachViewModelModelWithCodeDefinition | eachViewModelModelWithCodeDefinition viewModelModel = aViewModelModel ]
]

{ #category : #accessing }
GtViewModelModelsWithCodeDefinitions >> viewModelModels [
	^ viewModelModels
]

{ #category : #accessing }
GtViewModelModelsWithCodeDefinitions >> viewModelModels: anObject [
	viewModelModels := anObject
]

{ #category : #enumerating }
GtViewModelModelsWithCodeDefinitions >> viewModelModelsWithCodeDefinitionDo: aBlock [
	"Evaluate a given block with each ${class:GtViewModelModelWithCodeDefinition}$"

	self definitions do: aBlock
]
