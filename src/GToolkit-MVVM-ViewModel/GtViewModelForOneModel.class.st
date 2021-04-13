Class {
	#name : #GtViewModelForOneModel,
	#superclass : #GtViewModelModel,
	#instVars : [
		'children'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #adding }
GtViewModelForOneModel >> addChild: aGtNavigationViewModelModel [
	(self hasChild: aGtNavigationViewModelModel)
		ifTrue: [ ^ self ].

	children add: aGtNavigationViewModelModel.
	
	aGtNavigationViewModelModel isForMany
		ifTrue: [ aGtNavigationViewModelModel addParent: self ]
		ifFalse: [ aGtNavigationViewModelModel parent: self ]
]

{ #category : #'api - accessing' }
GtViewModelForOneModel >> childViewModelsName [
	^ self childViewModelsNameFor: self
]

{ #category : #accessing }
GtViewModelForOneModel >> children [
	^ children
]

{ #category : #accessing }
GtViewModelForOneModel >> children: anObject [
	children := anObject
]

{ #category : #'api - generation' }
GtViewModelForOneModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
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
GtViewModelForOneModel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	children do: [ :eachChildModel |
		| theChildrenAccessorsDefinition theChildrenAccessor |
		
		theChildrenAccessor := properties
			at: eachChildModel name
			ifAbsent: [ eachChildModel name ].

		theChildrenAccessorsDefinition := GtClassGenerator new
			templateClass: TGtViewModelChildrenForOneAccessorTemplate;
			className: #VirtialClass;
			packageName: 'MyPackage';
			templateMap: { 
				#__Parent_view_model_class__ -> self viewModelClassName.
				#__child_view_models__ -> (self childViewModelsNameFor: eachChildModel) uncapitalized.
				#__Child_view_models__ -> (self childViewModelsNameFor: eachChildModel) capitalized.
				#__model__ -> self modelGetterSelector uncapitalized.
				#__children__ -> theChildrenAccessor uncapitalized.
				#__Child_view_model_class__ -> eachChildModel viewModelClassName capitalized.
				#__child_parent_view_model_setter__ -> (eachChildModel parentViewModelSelectorNameFor: self) uncapitalized asSymbol asMutator.
				#__child_model_setter__ -> eachChildModel modelSetterSelector uncapitalized
			};
			generateBehaviorDefinition.

		self
			mergeBehaviorDefinition: theChildrenAccessorsDefinition instanceSideDefinition
			into: aViewModelDefinition ]
]

{ #category : #'api - generation' }
GtViewModelForOneModel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	self hasParent
		ifFalse: [ ^ self ].

	self
		generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition
		parentViewModelModel: self parent
]

{ #category : #testing }
GtViewModelForOneModel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
GtViewModelForOneModel >> hasParent [
	^ parent notNil
]

{ #category : #testing }
GtViewModelForOneModel >> hasParents [
	^ self hasParent
]

{ #category : #initialization }
GtViewModelForOneModel >> initialize [
	super initialize.
	
	children := OrderedCollection new
]

{ #category : #testing }
GtViewModelForOneModel >> isForOne [
	^ true
]

{ #category : #accessing }
GtViewModelForOneModel >> parent [
	^ parent
]

{ #category : #accessing }
GtViewModelForOneModel >> parent: anObject [
	parent := anObject
]

{ #category : #'api - accessing' }
GtViewModelForOneModel >> parentViewModelSelectorName [
	self
		assert: [ self hasParent ]
		description: [ 'Can not create parent selector if there is no parent' ].

	^ self parentViewModelSelectorNameFor: self parent
]

{ #category : #'api - accessing' }
GtViewModelForOneModel >> parents [
	^ { self parent }
]
