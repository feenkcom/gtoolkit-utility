Class {
	#name : #GtNavigationViewModelForManyModel,
	#superclass : #GtNavigationViewModelModel,
	#instVars : [
		'forOneModel'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #'private - methods' }
GtNavigationViewModelForManyModel >> addSelectionNotifierMethodTo: aViewModelDefinition selectionTrait: aSelectionTraitDefinition [
	self
		propertyChangeNotifierMethodFor: self selectionPropertyName
		inTrait: aSelectionTraitDefinition
		ifFound: [ :aMethodDefinition |
			| methodSourceCode |
			
			methodSourceCode := aMethodDefinition sourceCode, String cr, String cr, String tab, 
				'self announce: ',self selectionChangedAnnouncementName,' new'.

			aViewModelDefinition instanceSideDefinition methods
				addMethod: methodSourceCode
				protocol: aMethodDefinition protocol ]
]

{ #category : #'api - accessing' }
GtNavigationViewModelForManyModel >> childViewModelsName [
	^ self childViewModelsNameFor: self forOneModel
]

{ #category : #accessing }
GtNavigationViewModelForManyModel >> children [
	^ { self forOneModel }
]

{ #category : #accessing }
GtNavigationViewModelForManyModel >> forOneModel [
	^ forOneModel
]

{ #category : #accessing }
GtNavigationViewModelForManyModel >> forOneModel: anObject [
	forOneModel := anObject.
	forOneModel parent: self
]

{ #category : #'private - generation' }
GtNavigationViewModelForManyModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
	| aSelectionTraitDefinition aSelectionAnnouncementDefinition aDefinition |
	
	aSelectionTraitDefinition := self generateSelectionTraitIn: aPharoEnvironment.
	aSelectionAnnouncementDefinition := self generateSelectionChangedAnnouncementDefinitionIn: aPharoEnvironment.

	aDefinition := GtViewModelGenerator new
		environment: aPharoEnvironment;
		modelName: self model;
		viewModelName: self viewModelClassName;
		projectPrefix: self project;
		packageName: self package;
		traits: ({ aSelectionTraitDefinition });
		generateBehaviorDefinition.

	self generateDomainModelAccessorsFor: aDefinition.
	self generateChildViewModelsAccessorFor: aDefinition.
	self generateParentViewModelAccessorsFor: aDefinition.

	self
		addSelectionNotifierMethodTo: aDefinition
		selectionTrait: aSelectionTraitDefinition.

	^ { aSelectionTraitDefinition . aSelectionAnnouncementDefinition. aDefinition }
]

{ #category : #'private - generation' }
GtNavigationViewModelForManyModel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	| aDefinition |

	aDefinition := GtClassGenerator new
		templateClass: TGtNavigationViewModelChildrenForManyAccessorTemplate;
		className: #VirtialClass;
		packageName: 'MyPackage';
		templateMap: { 
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

{ #category : #'private - generation' }
GtNavigationViewModelForManyModel >> generateSelectionChangedAnnouncementDefinitionIn: aPharoEnvironment [
	| aDefinition |
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: self selectionChangedAnnouncementName.
	aDefinition superclass name: #Announcement.
	aDefinition category package name: self package.
	
	^ aDefinition
]

{ #category : #'private - generation' }
GtNavigationViewModelForManyModel >> generateSelectionTraitIn: aPharoEnvironment [
	^ GtWithPropertyTraitGenerator new
		environment: aPharoEnvironment;
		propertyName: self selectionPropertyName;
		propertySetter: 'select', self forOneModel name capitalized ,'ViewModel';
		propertyUnsetter: 'deselect', self forOneModel name capitalized ,'ViewModel';
		propertyType: self forOneModel viewModelClassName;
		propertyComparator: #=;
		projectPrefix: (self project, self prefix capitalized);
		packageName: self package;
		generateBehaviorDefinition
]

{ #category : #initialize }
GtNavigationViewModelForManyModel >> initialize [
	super initialize.
	
	model := #OrderedCollection
]

{ #category : #'api - accessing' }
GtNavigationViewModelForManyModel >> itemsAccessorSelector [
	^ properties
		at: #items
		ifAbsent: [ #yourself ]
]

{ #category : #private }
GtNavigationViewModelForManyModel >> propertyChangeNotifierMethodFor: aPropertyName inTrait: aTraitDefinition ifFound: aFoundBlock [
	aTraitDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = #propertyChangeNotifier: ]
			ifFound: [ :aPragmaNode |
				aPragmaNode values
					detect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue = aPropertyName ]
					ifFound: [ ^ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #'api - accessing' }
GtNavigationViewModelForManyModel >> selectionChangedAnnouncementName [
	^ '{project}{prefix}Selected{name}{suffix}ViewModelChanged'
		format: { 
			#project -> self project.
			#prefix -> self prefix capitalized.
			#name -> self forOneModel name capitalized.
			#suffix -> self suffix capitalized.
		} asDictionary
]

{ #category : #'api - accessing' }
GtNavigationViewModelForManyModel >> selectionPropertyName [
	^ 'selected', self forOneModel name capitalized ,'ViewModel'
]
