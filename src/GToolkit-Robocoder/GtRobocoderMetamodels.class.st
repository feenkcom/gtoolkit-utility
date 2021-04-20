Class {
	#name : #GtRobocoderMetamodels,
	#superclass : #Object,
	#instVars : [
		'ast',
		'models',
		'derives',
		'settings'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodels >> ast [
	^ ast
]

{ #category : #accessing }
GtRobocoderMetamodels >> ast: anObject [
	ast := anObject
]

{ #category : #accessing }
GtRobocoderMetamodels >> derives [
	^ derives
]

{ #category : #accessing }
GtRobocoderMetamodels >> derives: anObject [
	derives := anObject
]

{ #category : #'api - generation' }
GtRobocoderMetamodels >> generateCodeDefinitions [
	<return: #GtRobocoderMetamodelsWithCodeDefinitions>
	| anEnvironment viewModelCodeDefinitions |

	anEnvironment := GtPharoVirtualEnvironment new.

	viewModelCodeDefinitions := GtRobocoderMetamodelsWithCodeDefinitions new
		viewModelModels: self.

	viewModelCodeDefinitions definitions: (self models collect: [ :eachViewModelModel |
		| aDefinition |
		aDefinition := eachViewModelModel alreadyHasViewModel
			ifTrue: [ GtBehaviorDefinition fromBehavior: eachViewModelModel existingViewModelClass in: anEnvironment ]
			ifFalse: [ eachViewModelModel generateBehaviorDefinitionIn: anEnvironment ].

		GtRobocoderMetamodelWithCodeDefinition new
			allViewModelModelDefinitions: viewModelCodeDefinitions;
			viewModelModel: eachViewModelModel;
			definition: aDefinition ]).

	derives do: [ :eachDerive | eachDerive applyOnMetamodelsWithCodeDefinitions: viewModelCodeDefinitions ].
	viewModelCodeDefinitions definitions
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasViewModel not ]
		thenDo: [ :eachViewModelModelWithDefinition |
			eachViewModelModelWithDefinition derives do: [ :eachDerive |
				eachDerive applyOnViewModelModelWithCodeDefinition: eachViewModelModelWithDefinition ] ].

	^ viewModelCodeDefinitions
]

{ #category : #initialization }
GtRobocoderMetamodels >> initialize [
	super initialize.
	
	models := #().
	derives := #().
	settings := Dictionary new
]

{ #category : #accessing }
GtRobocoderMetamodels >> models [
	^ models
]

{ #category : #accessing }
GtRobocoderMetamodels >> models: anObject [
	models := anObject
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings [
	^ settings
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings: anObject [
	settings := anObject
]
