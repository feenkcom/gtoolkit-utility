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
	aGtNavigationViewModelModel parent: self
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
				#__child_view_models__ -> (self childViewModelsNameFor: eachChildModel) uncapitalized.
				#__Child_view_models__ -> (self childViewModelsNameFor: eachChildModel) capitalized.
				#__model__ -> self modelGetterSelector uncapitalized.
				#__children__ -> theChildrenAccessor uncapitalized.
				#__Child_view_model_class__ -> eachChildModel viewModelClassName capitalized.
				#__child_parent_view_model_setter__ -> eachChildModel parentViewModelSelectorName uncapitalized asSymbol asMutator.
				#__child_model_setter__ -> eachChildModel modelSetterSelector uncapitalized
			};
			generateBehaviorDefinition.

		self
			mergeBehaviorDefinition: theChildrenAccessorsDefinition instanceSideDefinition
			into: aViewModelDefinition ]
]

{ #category : #testing }
GtViewModelForOneModel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
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