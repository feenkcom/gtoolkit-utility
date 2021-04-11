Class {
	#name : #GtViewModelModels,
	#superclass : #Object,
	#instVars : [
		'ast',
		'models',
		'derives',
		'settings'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #accessing }
GtViewModelModels >> ast [
	^ ast
]

{ #category : #accessing }
GtViewModelModels >> ast: anObject [
	ast := anObject
]

{ #category : #accessing }
GtViewModelModels >> derives [
	^ derives
]

{ #category : #accessing }
GtViewModelModels >> derives: anObject [
	derives := anObject
]

{ #category : #'api - generation' }
GtViewModelModels >> generateCodeDefinitions [
	<return: #GtViewModelModelsWithCodeDefinitions>
	| anEnvironment viewModelCodeDefinitions |

	anEnvironment := GtPharoVirtualEnvironment new.

	viewModelCodeDefinitions := GtViewModelModelsWithCodeDefinitions new
		viewModelModels: self.

	viewModelCodeDefinitions definitions: (self models collect: [ :eachViewModelModel |
		GtViewModelModelWithCodeDefinition new
			allViewModelModelDefinitions: viewModelCodeDefinitions;
			viewModelModel: eachViewModelModel;
			definition: (eachViewModelModel generateBehaviorDefinitionIn: anEnvironment) ]).

	derives do: [ :eachDerive | eachDerive applyOnViewModelModelsWithCodeDefinitions: viewModelCodeDefinitions ].

	^ viewModelCodeDefinitions
]

{ #category : #initialization }
GtViewModelModels >> initialize [
	super initialize.
	
	models := #().
	derives := #().
	settings := Dictionary new
]

{ #category : #accessing }
GtViewModelModels >> models [
	^ models
]

{ #category : #accessing }
GtViewModelModels >> models: anObject [
	models := anObject
]

{ #category : #accessing }
GtViewModelModels >> settings [
	^ settings
]

{ #category : #accessing }
GtViewModelModels >> settings: anObject [
	settings := anObject
]
