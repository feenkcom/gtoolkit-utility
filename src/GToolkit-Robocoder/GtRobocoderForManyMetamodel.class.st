Class {
	#name : #GtRobocoderForManyMetamodel,
	#superclass : #GtRobocoderMetamodel,
	#instVars : [
		'forOneModel',
		'parents'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderForManyMetamodel >> addParent: aGtViewModelModel [
	(parents includes: aGtViewModelModel)
		ifTrue: [ ^ self ].

	parents add: aGtViewModelModel
]

{ #category : #'api - accessing' }
GtRobocoderForManyMetamodel >> childViewModelsName [
	^ self childViewModelsNameFor: self forOneModel
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> children [
	^ { self forOneModel }
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> forOneModel [
	^ forOneModel
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> forOneModel: anObject [
	forOneModel := anObject.
	forOneModel parent: self
]

{ #category : #'api - generation' }
GtRobocoderForManyMetamodel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	| aDefinition |

	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelChildrenForManyTemplate;
		mappings: { 
			#modelGetter -> self modelGetterSelector uncapitalized.
			#viewModelClass -> self viewModelClassName.
			
			#childObjects -> self childViewModelsName uncapitalized.
			#childObjectsClass -> self forOneModel viewModelClassName capitalized.
			
			#childModelsGetter -> self itemsAccessorSelector uncapitalized.
			#childModelSetter -> self forOneModel modelSetterSelectorName uncapitalized.
			#childParentObjectSetter -> self forOneModel parentViewModelSelectorName uncapitalized.
		};
		generate.

	self
		mergeBehaviorDefinition: aDefinition
		into: aViewModelDefinition
]

{ #category : #'api - generation' }
GtRobocoderForManyMetamodel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	self parents do: [ :eachParentViewModelModel |
		self
			generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition
			parentViewModelModel: eachParentViewModelModel ]
]

{ #category : #testing }
GtRobocoderForManyMetamodel >> hasParents [
	^ self parents notEmpty
]

{ #category : #initialize }
GtRobocoderForManyMetamodel >> initialize [
	super initialize.

	model := #OrderedCollection.
	parents := OrderedCollection new
]

{ #category : #'api - accessing' }
GtRobocoderForManyMetamodel >> itemsAccessorSelector [
	^ properties
		at: #items
		ifAbsent: [ #yourself ]
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> parents [
	^ parents
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> parents: anObject [
	parents := anObject asOrderedCollection
]
