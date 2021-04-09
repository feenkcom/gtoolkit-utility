Class {
	#name : #GtNavigationViewModelForOneModel,
	#superclass : #GtNavigationViewModelModel,
	#instVars : [
		'children'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #adding }
GtNavigationViewModelForOneModel >> addChild: aGtNavigationViewModelModel [
	(self hasChild: aGtNavigationViewModelModel)
		ifTrue: [ ^ self ].

	children add: aGtNavigationViewModelModel.
	aGtNavigationViewModelModel parent: self
]

{ #category : #accessing }
GtNavigationViewModelForOneModel >> children [
	^ children
]

{ #category : #accessing }
GtNavigationViewModelForOneModel >> children: anObject [
	children := anObject
]

{ #category : #'private - generation' }
GtNavigationViewModelForOneModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
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
	self generateSelectableChildAccessorsFor: aDefinition.
	
	^ { aDefinition }
]

{ #category : #'private - generation' }
GtNavigationViewModelForOneModel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	children do: [ :eachChildModel |
		properties
			at: eachChildModel name
			ifPresent: [ :theChildrenAccessor |
				| theChildrenAccessorsDefinition |
				
				theChildrenAccessorsDefinition := GtClassGenerator new
					templateClass: TGtNavigationViewModelChildrenForOneAccessorTemplate;
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
					into: aViewModelDefinition ] ]
]

{ #category : #testing }
GtNavigationViewModelForOneModel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #initialization }
GtNavigationViewModelForOneModel >> initialize [
	super initialize.
	
	children := OrderedCollection new.
]

{ #category : #testing }
GtNavigationViewModelForOneModel >> isForOne [
	^ true
]
