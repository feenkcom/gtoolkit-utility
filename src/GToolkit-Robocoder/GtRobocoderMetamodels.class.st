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
	| anEnvironment aGtRobocoderMetamodelsWithCodeDefinitions counter |

	anEnvironment := GtPharoVirtualEnvironment new.

	aGtRobocoderMetamodelsWithCodeDefinitions := GtRobocoderMetamodelsWithCodeDefinitions new
		viewModelModels: self.

	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinition: (self models collect: [ :eachViewModelModel |
		| aDefinition |
		aDefinition := eachViewModelModel alreadyHasClass
			ifTrue: [ GtBehaviorDefinition fromBehavior: eachViewModelModel existingViewModelClass in: anEnvironment ]
			ifFalse: [ eachViewModelModel generateBehavior ].

		anEnvironment registerBehavior: aDefinition.

		GtRobocoderMetamodelWithCodeDefinition new
			allViewModelModelDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions;
			metamodel: eachViewModelModel;
			definition: aDefinition ]).
	
	counter := 0.
	[ (self processDerivesOf: aGtRobocoderMetamodelsWithCodeDefinitions) and: [ counter < 10 ] ] whileTrue: [ counter := counter + 1 ].

	^ aGtRobocoderMetamodelsWithCodeDefinitions
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

{ #category : #'api - generation' }
GtRobocoderMetamodels >> processDerivesOf: aGtRobocoderMetamodelsWithCodeDefinitions [
	"Return true if the definition changed"
	<return: #Boolean>
	| thePreviousMetamodelsWithDefinitions |

	thePreviousMetamodelsWithDefinitions := aGtRobocoderMetamodelsWithCodeDefinitions copy.

	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinition
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasClass not ]
		thenDo: [ :eachViewModelModelWithDefinition |
			eachViewModelModelWithDefinition derives do: [ :eachDerive |
				eachDerive applyOnViewModelModelWithCodeDefinition: eachViewModelModelWithDefinition ] ].

	derives do: [ :eachDerive | eachDerive applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions ].
	
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinition
		with: thePreviousMetamodelsWithDefinitions metamodelsWithCodeDefinition
		do: [ :aCurrentMetamodelWithDefinition :thePreviousMetamodelWithDefinition |
			(aCurrentMetamodelWithDefinition definition differenceWith: thePreviousMetamodelWithDefinition definition)
				hasDifference ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings [
	^ settings
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings: anObject [
	settings := anObject
]
