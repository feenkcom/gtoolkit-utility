Class {
	#name : #GtNavigationViewModelsGenerator,
	#superclass : #Object,
	#traits : 'TGtNavigationViewModelProgramNodeVisitor',
	#classTraits : 'TGtNavigationViewModelProgramNodeVisitor classTrait',
	#instVars : [
		'hierarchy',
		'ast',
		'viewModels',
		'environment',
		'settings',
		'definitions',
		'changes'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #private }
GtNavigationViewModelsGenerator >> ensureViewModelForManyExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtNavigationViewModelForManyModel new
				name: aNameString.
				
			viewModels add: aNewViewModel.
			aNewViewModel ].
]

{ #category : #private }
GtNavigationViewModelsGenerator >> ensureViewModelForOneExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtNavigationViewModelForOneModel new
				name: aNameString.
				
			viewModels add: aNewViewModel.
			aNewViewModel ]
]

{ #category : #translating }
GtNavigationViewModelsGenerator >> generate [
	ast := GtNavigationViewModelParser
		parse: self hierarchy
		startingAt: GtNavigationViewModelParser startingStateForFullDefinition.
	
	viewModels := OrderedCollection new.
	settings := Dictionary new.
	
	self accept: ast.
	
	viewModels do: [ :eachModel | eachModel settings: settings ].
	
	environment := GtPharoVirtualEnvironment new.
	definitions := OrderedCollection new.
	viewModels do: [ :eachModel |
		| theNewDefinitions |
		
		theNewDefinitions := (eachModel generateBehaviorDefinitionIn: environment) asOrderedCollection.
		theNewDefinitions do: [ :eachNewDefinition |
			(definitions includes: eachNewDefinition)
				ifFalse: [ definitions add: eachNewDefinition ] ] ].

	changes := RBCompositeRefactoryChange named: 'Generate view models'.
	definitions do: [ :eachDefinition | changes addChange: eachDefinition createChange ].

	^ changes
]

{ #category : #'gt-extension' }
GtNavigationViewModelsGenerator >> gtBehaviorsFor: aView [
	<gtView>
	
	definitions ifNil: [ ^ aView empty ].
	
	^ aView list
		title: 'Behaviors';
		priority: 5;
		items: [ definitions ]
]

{ #category : #'gt-extension' }
GtNavigationViewModelsGenerator >> gtChangesFor: aView [
	<gtView>
	
	changes ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Changes';
		priority: 1;
		object: [ changes ];
		view: #gtChangesFor:
]

{ #category : #'gt-extension' }
GtNavigationViewModelsGenerator >> gtTreeFor: aView [
	<gtView>
	
	viewModels ifEmpty: [ ^ aView empty ].
	
	^ aView forward
		title: 'View Models';
		priority: 5;
		object: [ viewModels first ];
		view: #gtTreeFor:
]

{ #category : #accessing }
GtNavigationViewModelsGenerator >> hierarchy [
	^ hierarchy
]

{ #category : #accessing }
GtNavigationViewModelsGenerator >> hierarchy: aString [
	hierarchy := aString
]

{ #category : #private }
GtNavigationViewModelsGenerator >> viewModelForProperty: aPropertyNode ifFound: aBlock [
	| aName |

	aName := ((aPropertyNode parentOfType: GtNavigationViewModelDefinitionNode)
		ifNil: [ ^ self ]) fullNameString.

	^ self viewModelNamed: aName ifFound: aBlock
]

{ #category : #private }
GtNavigationViewModelsGenerator >> viewModelNamed: aFullName ifAbsent: aBlock [
	^ viewModels detect: [ :each | each name = aFullName ] ifNone: aBlock
]

{ #category : #private }
GtNavigationViewModelsGenerator >> viewModelNamed: aFullName ifFound: aBlock [
	^ viewModels detect: [ :each | each name = aFullName ] ifFound: aBlock
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitLevelForMany: aLevelForMany [
	| aParentModel aChildModel |

	aParentModel := self ensureViewModelForManyExists: aLevelForMany fullNameString.
	aChildModel := self ensureViewModelForOneExists: aLevelForMany nameString.
	
	aParentModel forOneModel: aChildModel
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitLevelForOne: aLevelForOne [
	self ensureViewModelForOneExists: aLevelForOne fullNameString
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitModelAnnotation: aModelAnnotation [
	| aViewModel |
	
	aViewModel := self
		viewModelNamed: aModelAnnotation parent level fullNameString
		ifAbsent: [ ^ self ].
	
	aViewModel model: aModelAnnotation nameString.
	aViewModel modelApi: aModelAnnotation apiNameString
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitNestedLevel: aNestedLevel [
	| aParentViewModel aChildLevel theChildNames | 
	self visitLevel: aNestedLevel.

	aParentViewModel := self
		viewModelNamed: aNestedLevel parentLevel nameString
		ifAbsent: [ ^ self ].
	
	aChildLevel := aNestedLevel childLevel.
	
	theChildNames := aChildLevel isCompositeLevel
		ifTrue: [ aChildLevel items collect: #fullNameString ]
		ifFalse: [ { aChildLevel fullNameString } ].
	
	theChildNames do: [ :eachChildName |
		self
			viewModelNamed: eachChildName
			ifFound: [ :eachChildModel | aParentViewModel addChild: eachChildModel ] ].
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitProperties: aProperties [
	| theProperties |
	self visitProgram: aProperties.
	
	theProperties := (aProperties properties collect: [ :eachProperty |
		eachProperty nameString -> eachProperty literalValue
	]) asDictionary.

	self
		viewModelForProperty: aProperties
		ifFound: [ :aViewModelModel |
			aViewModelModel properties: theProperties ]
]

{ #category : #generated }
GtNavigationViewModelsGenerator >> visitSetting: aSetting [
	settings
		at: aSetting nameString asSymbol
		put: aSetting literalString
]
