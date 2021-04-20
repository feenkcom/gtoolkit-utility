Class {
	#name : #GtRobocoderMetamodel,
	#superclass : #Object,
	#instVars : [
		'name',
		'model',
		'modelApi',
		'settings',
		'properties',
		'parent',
		'definition',
		'derives'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #'api - derives' }
GtRobocoderMetamodel >> addDerive: aDerive [
	derives add: aDerive
]

{ #category : #testing }
GtRobocoderMetamodel >> alreadyHasViewModel [
	^ self properties includesKey: #viewModel
]

{ #category : #private }
GtRobocoderMetamodel >> childViewModelsNameFor: aChildViewModel [
	^ ('{prefix}{name}{suffix}ViewModel{ending}'
		format: { 
			#prefix -> self prefix uncapitalized.
			#name -> aChildViewModel name capitalized.
			#suffix -> self suffix capitalized.
			#ending -> (aChildViewModel isForMany ifTrue: [ '' ] ifFalse: [ 's' ])
		} asDictionary) uncapitalized
]

{ #category : #accessing }
GtRobocoderMetamodel >> definition [
	^ definition
]

{ #category : #accessing }
GtRobocoderMetamodel >> definition: anObject [
	definition := anObject
]

{ #category : #'api - derives' }
GtRobocoderMetamodel >> derives [
	^ derives
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> existingViewModelClass [
	^ self class environment at: self existingViewModelName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> existingViewModelName [
	^ (self properties at: #viewModel) asSymbol
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForAnnouncements [
	^ self fullTagWith: 'Events'
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForTraits [
	^ self fullTagWith: 'Support'
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForViewModel [
	^ self fullTagWith: 'View Models'
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagWith: aSubTag [
	^ self tag
		ifEmpty: [ aSubTag ]
		ifNotEmpty: [ :aTag | aTag , ' - ', aSubTag ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodel >> generateBehaviorDefinitionIn: aPharoEnvironment [
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
GtRobocoderMetamodel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	self subclassResponsibility
]

{ #category : #'api - generation' }
GtRobocoderMetamodel >> generateDomainModelAccessorsFor: aViewModelDefinition [
	self modelApiTrait
		ifNotNil: [ :aTrait |
			| aDomainModelTraitDefinition |
			aDomainModelTraitDefinition := GtTraitDefinition fromTrait: aTrait in: aViewModelDefinition environment.
			aViewModelDefinition instanceSideDefinition traits addTrait: aDomainModelTraitDefinition ]
		ifNil: [
			| aDomainModelTraitDefinition |
			aDomainModelTraitDefinition := GtWithDomainModelTraitGenerator new
				modelName: self name;
				projectPrefix: self project, self prefix capitalized;
				packageName: self package;
				generateBehaviorDefinition.
			
			self mergeBehaviorDefinition: aDomainModelTraitDefinition into: aViewModelDefinition ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	self subclassResponsibility
]

{ #category : #'api - generation' }
GtRobocoderMetamodel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition parentViewModelModel: aParentViewModelModel [
	| aTemplateDefinition |

	aTemplateDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelParentAccessorTemplate;
		mappings: { 
			"A class of the object to which the api should be added (used for documentation generation)"
			#objectClass -> self viewModelClassName.
			#parentObjectName -> aParentViewModelModel name.
			#parentObject -> (self parentViewModelSelectorNameFor: aParentViewModelModel) uncapitalized.
			#parentObjectClass -> aParentViewModelModel viewModelClassName capitalized
		};
		generate.

	self
		mergeBehaviorDefinition: aTemplateDefinition
		into: aViewModelBehaviorDefinition
]

{ #category : #'gt-extension' }
GtRobocoderMetamodel >> gtInfoFor: aView [
	<gtView>

	^ (({
		'View model class name' -> self viewModelClassName.
		'Model getter' -> self modelGetterSelector printString.
		'Model setter' -> self modelSetterSelector printString.
		'Parent view model name' -> (self hasParent
			ifTrue: [ self parentViewModelSelectorName printString ] 
			ifFalse: [ '-----' ]).
	 } asOrderedDictionary, properties, settings) gtItemsFor: aView)
			title: 'Info';
			priority: 2
]

{ #category : #'gt-extension' }
GtRobocoderMetamodel >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandAll
]

{ #category : #testing }
GtRobocoderMetamodel >> hasParents [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtRobocoderMetamodel >> initialize [
	super initialize.

	settings := Dictionary new.
	properties := Dictionary new.
	derives := OrderedCollection new
]

{ #category : #testing }
GtRobocoderMetamodel >> isForMany [
	^ self isForOne not
]

{ #category : #testing }
GtRobocoderMetamodel >> isForOne [
	^ false
]

{ #category : #private }
GtRobocoderMetamodel >> mergeBehaviorDefinition: aBehaviorDefinition into: aViewModelDefinition [
	"Merge the given behavior (trait or class) definition into the view model definition.
	This is useful when we want to actually compile-in methods and slots from template behaviors."
	
	aBehaviorDefinition slots do: [ :eachSlot |
		aViewModelDefinition instanceSideDefinition slots
			addSlotNamed: eachSlot name ].
		
	aBehaviorDefinition methods do: [ :eachMethod |
		aViewModelDefinition instanceSideDefinition methods
			addMethod: eachMethod sourceCode
			protocol: eachMethod protocol ].
		
	aViewModelDefinition comment
		content: aViewModelDefinition comment content, String cr, aBehaviorDefinition comment content
]

{ #category : #accessing }
GtRobocoderMetamodel >> model [
	^ model
]

{ #category : #accessing }
GtRobocoderMetamodel >> model: anObject [
	model := anObject asSymbol
]

{ #category : #accessing }
GtRobocoderMetamodel >> modelApi [
	^ modelApi
]

{ #category : #accessing }
GtRobocoderMetamodel >> modelApi: anObject [
	modelApi := anObject
]

{ #category : #accessing }
GtRobocoderMetamodel >> modelApiTrait [
	self modelApi
		ifNil: [ ^ nil ].

	^ self class environment
		at: self modelApi asSymbol
		ifPresent: [ :aGlobal |
			aGlobal isTrait
				ifTrue: [ aGlobal ]
				ifFalse: [ nil ] ]
		ifAbsent: [ nil ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> modelGetterSelector [
	| aFallbackSelector |

	aFallbackSelector := (self name, 'Model') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelGetter in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> modelNameForViewModel [
	^ self model ifNil: [ self name ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> modelSetterSelector [
	^ self modelSetterSelectorName asSymbol asMutator
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> modelSetterSelectorName [
	| aFallbackSelector |

	aFallbackSelector := (self name, 'Model') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelSetter in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector copyReplaceAll: ':' with: '' ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> modelTesterSelector [
	| aFallbackSelector |

	aFallbackSelector := ('has', self name capitalized, 'Model') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelTester in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodel >> name: anObject [
	name := anObject
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> package [
	^ settings at: #package ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> parentViewModelSelectorNameFor: aParentViewModelModel [
	^ ('parent', self prefix capitalized, aParentViewModelModel name capitalized, self suffix capitalized, 'ViewModel') asSymbol
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> parents [
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> prefix [
	^ settings at: #prefix ifAbsent: [ '' ]
]

{ #category : #printing }
GtRobocoderMetamodel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	
	self isForOne
		ifTrue: [ aStream nextPutAll: 'ForOne' ]
		ifFalse: [ aStream nextPutAll: 'ForMany' ].
	
	aStream
		nextPutAll: ' model: ';
		print: model.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> project [
	^ settings at: #project ifAbsent: [ '' ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> properties [
	^ properties
]

{ #category : #accessing }
GtRobocoderMetamodel >> properties: anObject [
	properties := anObject
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inBehavior: aBehaviorDefinition ifFound: aFoundBlock [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aMethodType ]
			ifFound: [ :aPragmaNode |
				aPragmaNode values
					detect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue = aPropertyName ]
					ifFound: [ ^ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aBehaviorDefinition [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	self
		propertyMethodFor: aPropertyName
		ofType: aMethodType
		inViewModelBehavior: aBehaviorDefinition
		ifFound: [ :aMethod | ^ aMethod ].

	^ nil
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aViewModelBehaviorDefinition ifFound: aFoundBlock [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			propertyMethodFor: aPropertyName
			ofType: aMethodType
			inBehavior: eachTrait
			ifFound: [ :aMethod | ^ aFoundBlock value: aMethod ] ].

	self
		propertyMethodFor: aPropertyName
		ofType: aMethodType
		inBehavior: aViewModelBehaviorDefinition instanceSideDefinition
		ifFound: [ :aMethod | ^ aFoundBlock value: aMethod ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> propertyNamed: aPropertyName put: aPropertyValue [
	self properties at: aPropertyName asSymbol put: aPropertyValue
]

{ #category : #accessing }
GtRobocoderMetamodel >> settings [
	^ settings
]

{ #category : #accessing }
GtRobocoderMetamodel >> settings: anObject [
	settings := anObject
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> suffix [
	^ settings at: #suffix ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> tag [
	^ settings at: #tag ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> viewModelClassName [
	properties
		at: #viewModel
		ifPresent: [ :aViewModelName | ^ aViewModelName ].

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self project;
			nextPutAll: self prefix capitalized;
			nextPutAll: self name capitalized;
			nextPutAll: self suffix capitalized;
			nextPutAll: 'ViewModel' ]
]
