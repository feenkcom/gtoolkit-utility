Class {
	#name : #GtViewModelModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'model',
		'modelApi',
		'settings',
		'properties',
		'parent',
		'definition'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #private }
GtViewModelModel >> childViewModelsNameFor: aChildViewModel [
	^ ('{prefix}{name}{suffix}ViewModel{ending}'
		format: { 
			#prefix -> self prefix uncapitalized.
			#name -> aChildViewModel name capitalized.
			#suffix -> self suffix capitalized.
			#ending -> (aChildViewModel isForMany ifTrue: [ '' ] ifFalse: [ 's' ])
		} asDictionary) uncapitalized
]

{ #category : #accessing }
GtViewModelModel >> definition [
	^ definition
]

{ #category : #accessing }
GtViewModelModel >> definition: anObject [
	definition := anObject
]

{ #category : #'api - generation' }
GtViewModelModel >> generateBehaviorDefinitionIn: aPharoEnvironment [
	^ self subclassResponsibility
]

{ #category : #'api - generation' }
GtViewModelModel >> generateDomainModelAccessorsFor: aViewModelDefinition [
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
GtViewModelModel >> generateParentViewModelAccessorsFor: aViewModelBehaviorDefinition [
	| aTemplateDefinition |

	self hasParent
		ifFalse: [ ^ self ].

	aTemplateDefinition := GtTraitGenerator new
		templateTrait: TGtViewModelParentAccessorTemplate;
		traitName: #Virtial;
		packageName: 'MyPackage';
		templateMap: { 
			#__view_model__ -> self parentViewModelSelectorName uncapitalized.
			#__View_model__ -> self parentViewModelSelectorName capitalized.
			#__View_model_class__ -> self parent viewModelClassName capitalized
		};
		generateBehaviorDefinition.

	self
		mergeBehaviorDefinition: aTemplateDefinition
		into: aViewModelBehaviorDefinition
]

{ #category : #'gt-extension' }
GtViewModelModel >> gtInfoFor: aView [
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
GtViewModelModel >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandAll
]

{ #category : #testing }
GtViewModelModel >> hasParent [
	^ parent notNil
]

{ #category : #initialization }
GtViewModelModel >> initialize [
	super initialize.

	settings := Dictionary new.
	properties := Dictionary new
]

{ #category : #testing }
GtViewModelModel >> isForMany [
	^ self isForOne not
]

{ #category : #testing }
GtViewModelModel >> isForOne [
	^ false
]

{ #category : #private }
GtViewModelModel >> mergeBehaviorDefinition: aBehaviorDefinition into: aViewModelDefinition [
	"Merge the given behavior (trait or class) definition into the view model definition.
	This is useful when we want to actually compile-in methods and slots from template behaviors."
	
	aBehaviorDefinition slots do: [ :eachSlot |
		aViewModelDefinition instanceSideDefinition slots
			addSlotNamed: eachSlot name ].
		
	aBehaviorDefinition methods do: [ :eachMethod |
		aViewModelDefinition instanceSideDefinition methods
			addMethod: eachMethod sourceCode
			protocol: eachMethod protocol ]
]

{ #category : #accessing }
GtViewModelModel >> model [
	^ model
]

{ #category : #accessing }
GtViewModelModel >> model: anObject [
	model := anObject asSymbol
]

{ #category : #accessing }
GtViewModelModel >> modelApi [
	^ modelApi
]

{ #category : #accessing }
GtViewModelModel >> modelApi: anObject [
	modelApi := anObject
]

{ #category : #accessing }
GtViewModelModel >> modelApiTrait [
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
GtViewModelModel >> modelGetterSelector [
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
GtViewModelModel >> modelNameForViewModel [
	^ self model ifNil: [ self name ]
]

{ #category : #'api - accessing' }
GtViewModelModel >> modelSetterSelector [
	| aFallbackSelector |

	aFallbackSelector := (self name, 'Model:') asSymbol.

	^ modelApi
		ifNotNil: [ :anApiTraitName |
			self class environment
				at: anApiTraitName asSymbol
				ifPresent: [ :aTrait |
					(Pragma allNamed: #modelSetter in: aTrait)
						ifEmpty: [ aFallbackSelector ]
						ifNotEmpty: [ :thePragmas | thePragmas first method selector ] ]
				ifAbsent: [ aFallbackSelector ] ]
		ifNil: [ aFallbackSelector ]
]

{ #category : #'api - accessing' }
GtViewModelModel >> modelTesterSelector [
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
GtViewModelModel >> name [
	^ name
]

{ #category : #accessing }
GtViewModelModel >> name: anObject [
	name := anObject
]

{ #category : #'api - accessing' }
GtViewModelModel >> package [
	^ settings at: #package ifAbsent: [ '' ]
]

{ #category : #accessing }
GtViewModelModel >> parent [
	^ parent
]

{ #category : #accessing }
GtViewModelModel >> parent: anObject [
	parent := anObject
]

{ #category : #'api - accessing' }
GtViewModelModel >> parentViewModelSelectorName [
	self
		assert: [ self hasParent ]
		description: [ 'Can not create parent selector if there is no parent' ].

	^ ('parent', self prefix capitalized, self parent name capitalized, self suffix capitalized, 'ViewModel') asSymbol
]

{ #category : #'api - accessing' }
GtViewModelModel >> prefix [
	^ settings at: #prefix ifAbsent: [ '' ]
]

{ #category : #printing }
GtViewModelModel >> printOn: aStream [
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
GtViewModelModel >> project [
	^ settings at: #project ifAbsent: [ '' ]
]

{ #category : #accessing }
GtViewModelModel >> properties [
	^ properties
]

{ #category : #accessing }
GtViewModelModel >> properties: anObject [
	properties := anObject
]

{ #category : #private }
GtViewModelModel >> propertyMethodFor: aPropertyName ofType: aMethodType inBehavior: aBehaviorDefinition ifFound: aFoundBlock [
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
GtViewModelModel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aBehaviorDefinition [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	self
		propertyMethodFor: aPropertyName
		ofType: aMethodType
		inViewModelBehavior: aBehaviorDefinition
		ifFound: [ :aMethod | ^ aMethod ].

	^ nil
]

{ #category : #private }
GtViewModelModel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aViewModelBehaviorDefinition ifFound: aFoundBlock [
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
GtViewModelModel >> settings [
	^ settings
]

{ #category : #accessing }
GtViewModelModel >> settings: anObject [
	settings := anObject
]

{ #category : #'api - accessing' }
GtViewModelModel >> suffix [
	^ settings at: #suffix ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
GtViewModelModel >> viewModelClassName [
	properties
		at: #name
		ifPresent: [ :aViewModelName | ^ aViewModelName ].


	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self project;
			nextPutAll: self prefix capitalized;
			nextPutAll: self name capitalized;
			nextPutAll: self suffix capitalized;
			nextPutAll: 'ViewModel' ]
]
