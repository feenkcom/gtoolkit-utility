Class {
	#name : #GtNavigationViewModelsGenerator,
	#superclass : #Object,
	#traits : 'TGtNavigationViewModelProgramNodeVisitor',
	#classTraits : 'TGtNavigationViewModelProgramNodeVisitor classTrait',
	#instVars : [
		'hierarchy',
		'ast',
		'viewModels'
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

	self accept: ast
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
	
	aParentModel addChild: aChildModel
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
	
	aViewModel model: aModelAnnotation nameString
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
