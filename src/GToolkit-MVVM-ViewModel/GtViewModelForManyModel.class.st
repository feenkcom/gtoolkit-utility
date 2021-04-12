Class {
	#name : #GtViewModelForManyModel,
	#superclass : #GtViewModelModel,
	#instVars : [
		'forOneModel'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #'api - accessing' }
GtViewModelForManyModel >> childViewModelsName [
	^ self childViewModelsNameFor: self forOneModel
]

{ #category : #accessing }
GtViewModelForManyModel >> children [
	^ { self forOneModel }
]

{ #category : #accessing }
GtViewModelForManyModel >> forOneModel [
	^ forOneModel
]

{ #category : #accessing }
GtViewModelForManyModel >> forOneModel: anObject [
	forOneModel := anObject.
	forOneModel parent: self
]

{ #category : #'api - generation' }
GtViewModelForManyModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
	| aDefinition |

	aDefinition := GtViewModelGenerator new
		environment: aPharoEnvironment;
		modelName: self modelNameForViewModel;
		viewModelName: self viewModelClassName;
		projectPrefix: self project;
		packageName: self package;
		tagName: self fullTagForViewModel;
		generateBehaviorDefinition.

	self generateDomainModelAccessorsFor: aDefinition.
	self generateChildViewModelsAccessorFor: aDefinition.
	self generateParentViewModelAccessorsFor: aDefinition.

	^ aDefinition
]

{ #category : #'api - generation' }
GtViewModelForManyModel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	| aDefinition |

	aDefinition := GtClassGenerator new
		templateClass: TGtViewModelChildrenForManyAccessorTemplate;
		className: #VirtialClass;
		packageName: 'MyPackage';
		templateMap: { 
			#__View_model_class_name__ -> self viewModelClassName.
			#__child_view_models__ -> self childViewModelsName uncapitalized.
			#__Child_view_models__ -> self childViewModelsName capitalized.
			#__model__ -> self modelGetterSelector uncapitalized.
			#__children__ -> self itemsAccessorSelector uncapitalized.
			#__Child_view_model_class__ -> self forOneModel viewModelClassName capitalized.
			#__child_parent_view_model_setter__ -> self forOneModel parentViewModelSelectorName uncapitalized asSymbol asMutator.
			#__child_model_setter__ -> self forOneModel modelSetterSelector uncapitalized
		};
		generateBehaviorDefinition.

	self
		mergeBehaviorDefinition: aDefinition instanceSideDefinition
		into: aViewModelDefinition
]

{ #category : #initialize }
GtViewModelForManyModel >> initialize [
	super initialize.
	
	model := #OrderedCollection
]

{ #category : #'api - accessing' }
GtViewModelForManyModel >> itemsAccessorSelector [
	^ properties
		at: #items
		ifAbsent: [ #yourself ]
]
