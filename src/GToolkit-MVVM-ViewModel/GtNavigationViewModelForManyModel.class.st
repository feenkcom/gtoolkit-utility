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
	^ '{prefix}{name}{suffix}ViewModels'
		format: { 
			#prefix -> self prefix uncapitalized.
			#name -> self forOneModel name capitalized.
			#suffix -> self suffix capitalized.
		} asDictionary
]

{ #category : #accessing }
GtNavigationViewModelForManyModel >> children [
	^ { self forOneModel }
]

{ #category : #private }
GtNavigationViewModelForManyModel >> createItemsViewCodersSourceCode [
	^
'create{childViewModelsName}
	^ self {modelGetter} {itemsAccessor} collect: [ :eachModel |
		{forOneViewModel} new
			pharoPackagesNavigationViewModel: self;
			{childModelSetter} eachModel ]'
	format: { 
		#childViewModelsName -> self childViewModelsName capitalized.
		#modelGetter -> self modelGetterSelector.
		#itemsAccessor -> self itemsAccessorSelector.
		#forOneViewModel -> self forOneModel viewModelClassName.
		#childModelSetter -> self forOneModel modelSetterSelector
	} asDictionary
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
	| aSelectionTraitDefinition aSelectionAnnouncementDefinition aModelTraitDefinition aDefinition |
	
	aSelectionTraitDefinition := self generateSelectionTraitIn: aPharoEnvironment.
	aSelectionAnnouncementDefinition := self generateSelectionChangedAnnouncementDefinitionIn: aPharoEnvironment.

	aModelTraitDefinition := self modelApiTrait
		ifNotNil: [ :aTrait | GtTraitDefinition fromTrait: aTrait in: aPharoEnvironment ].

	aDefinition := GtViewModelGenerator new
		environment: aPharoEnvironment;
		modelName: self model;
		viewModelName: self viewModelClassName;
		projectPrefix: self project;
		packageName: self package;
		traits: ({ aSelectionTraitDefinition . aModelTraitDefinition } select: #notNil);
		generateBehaviorDefinition.

	aDefinition instanceSideDefinition slots addSlotNamed: self childViewModelsName.

	aDefinition instanceSideDefinition methods
		addMethod: (self createItemsViewCodersSourceCode)
		protocol: 'private - instance creation'.
		
	aDefinition instanceSideDefinition methods
		addMethod: (self itemsViewCodersSourceCode)
		protocol: 'api - accessing'.

	self generateParentViewModelAccessorsFor: aDefinition.

	self
		addSelectionNotifierMethodTo: aDefinition
		selectionTrait: aSelectionTraitDefinition.

	^ { aSelectionTraitDefinition . aSelectionAnnouncementDefinition. aDefinition }
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
GtNavigationViewModelForManyModel >> itemsViewCodersSourceCode [
	^
'{childViewModelsName}
	^  {childViewModelsName} ifNil: [ {childViewModelsName} := self create{childViewModelsNameCapitalized} ]'
	format: { 
		#childViewModelsName -> self childViewModelsName.
		#childViewModelsNameCapitalized -> self childViewModelsName capitalized.
	} asDictionary
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
