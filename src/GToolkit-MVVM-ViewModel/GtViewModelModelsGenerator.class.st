"
! View-Model Models Generator
Given a view models declaration source code it parses (using ${class:GtViewModelParser}$) and creates models (${class:GtViewModelModels}$) of the declated view-models.
"
Class {
	#name : #GtViewModelModelsGenerator,
	#superclass : #Object,
	#traits : 'TGtViewModelProgramNodeVisitor',
	#classTraits : 'TGtViewModelProgramNodeVisitor classTrait',
	#instVars : [
		'sourceCode',
		'viewModels',
		'settings',
		'derives'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #private }
GtViewModelModelsGenerator >> ensureViewModelForManyExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtViewModelForManyModel new
				name: aNameString.
				
			viewModels add: aNewViewModel.
			aNewViewModel ].
]

{ #category : #private }
GtViewModelModelsGenerator >> ensureViewModelForOneExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtViewModelForOneModel new
				name: aNameString.
				
			viewModels add: aNewViewModel.
			aNewViewModel ]
]

{ #category : #translating }
GtViewModelModelsGenerator >> generate [
	<return: #GtViewModelModels>
	| anAst |

	anAst := GtViewModelParser
		parse: self sourceCode
		startingAt: GtViewModelParser startingStateForFullDefinition.

	viewModels := OrderedCollection new.
	settings := Dictionary new.
	derives := Set new.

	self accept: anAst.

	viewModels do: [ :eachModel | eachModel settings: settings ].

	^ GtViewModelModels new
		ast: anAst;
		models: viewModels asArray;
		settings: settings;
		derives: derives asArray;
		yourself
]

{ #category : #'gt-extension' }
GtViewModelModelsGenerator >> gtTreeFor: aView [
	<gtView>
	
	viewModels ifEmpty: [ ^ aView empty ].
	
	^ aView forward
		title: 'View Models';
		priority: 5;
		object: [ viewModels first ];
		view: #gtTreeFor:
]

{ #category : #accessing }
GtViewModelModelsGenerator >> hierarchy [
	^ sourceCode
]

{ #category : #accessing }
GtViewModelModelsGenerator >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtViewModelModelsGenerator >> sourceCode: aSting [
	sourceCode := aSting
]

{ #category : #private }
GtViewModelModelsGenerator >> viewModelForProperty: aPropertyNode ifFound: aBlock [
	| aName |

	aName := ((aPropertyNode parentOfType: GtViewModelDefinitionNode)
		ifNil: [ ^ self ]) fullNameString.

	^ self viewModelNamed: aName ifFound: aBlock
]

{ #category : #private }
GtViewModelModelsGenerator >> viewModelNamed: aFullName ifAbsent: aBlock [
	^ viewModels detect: [ :each | each name = aFullName ] ifNone: aBlock
]

{ #category : #private }
GtViewModelModelsGenerator >> viewModelNamed: aFullName ifFound: aBlock [
	^ viewModels detect: [ :each | each name = aFullName ] ifFound: aBlock
]

{ #category : #generated }
GtViewModelModelsGenerator >> visitLevelForMany: aLevelForMany [
	| aParentModel aChildModel |

	aParentModel := self ensureViewModelForManyExists: aLevelForMany fullNameString.
	aChildModel := self ensureViewModelForOneExists: aLevelForMany nameString.
	
	aParentModel forOneModel: aChildModel
]

{ #category : #generated }
GtViewModelModelsGenerator >> visitLevelForOne: aLevelForOne [
	self ensureViewModelForOneExists: aLevelForOne fullNameString
]

{ #category : #generated }
GtViewModelModelsGenerator >> visitModelAnnotation: aModelAnnotation [
	| aViewModel |
	
	aViewModel := self
		viewModelNamed: aModelAnnotation parent level fullNameString
		ifAbsent: [ ^ self ].
	
	aViewModel model: aModelAnnotation nameString.
	aViewModel modelApi: aModelAnnotation apiNameString
]

{ #category : #generated }
GtViewModelModelsGenerator >> visitNestedLevel: aNestedLevel [
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
GtViewModelModelsGenerator >> visitProperties: aProperties [
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
GtViewModelModelsGenerator >> visitSetting: aSetting [

	aSetting nameString = 'derive'
		ifTrue: [
			GtViewModelDerive
				deriveNamed: aSetting literalString
				ifFound: [ :aDeriveClass | derives add: aDeriveClass new ].
			^ self ].
	
	settings
		at: aSetting nameString asSymbol
		put: aSetting literalString
]
