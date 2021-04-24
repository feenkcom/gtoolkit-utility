Class {
	#name : #GtRobocoderMetamodelWithCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'viewModelModel',
		'definition',
		'extraDefinitions',
		'allViewModelModelDefinitions',
		'subscriptions'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodSelectorWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	^ (self
		anyMethodWithPragmaNamedOrNil: aPragmaName
		andValue: aPragmaValue
		inFullClass: aFullClassDefinition)
			ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodSelectorWithPragmaNamedOrNil: aPragmaName inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	^ (self
		anyMethodWithPragmaNamedOrNil: aPragmaName
		inFullClass: aFullClassDefinition)
			ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inFullClass: aFullClassDefinition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].

	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodWithPragmaNamedOrNil: aPragmaName inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		inFullClass: aFullClassDefinition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].

	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode |
				aPragmaNode values
					detect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue = aPragmaValue ]
					ifFound: [ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aFullClassDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			andValue: aPragmaValue
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inBehaviorDefinition: aFullClassDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode | aFoundBlock value: eachMethod ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName inFullClass: aFullClassDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aFullClassDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		inBehaviorDefinition: aFullClassDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinition: aGtCodeDefinition [
	extraDefinitions removeAllSuchThat: [ :eachExtraDefinition |
		eachExtraDefinition name = aGtCodeDefinition name ]. 
	extraDefinitions add: aGtCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinitions: aCollectionOfGtCodeDefinition [
	extraDefinitions addAll: aCollectionOfGtCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addSubscriptionWhen: anAnnouncementName in: aModelGetteer send: aSymbol [
	subscriptions
		at: anAnnouncementName asSymbol
		put: aModelGetteer -> aSymbol
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> allViewModelModelDefinitions [
	^ allViewModelModelDefinitions
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> allViewModelModelDefinitions: anObject [
	allViewModelModelDefinitions := anObject
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> alreadyHasClass [
	^ self metamodel alreadyHasClass
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodNamedOrNil: aSelector [
	"Find any method with a given selector"
	<return: #GtPharoMethodDefinition>
	
	self definition instanceSideDefinition methods
		methodNamed: aSelector
		ifFound: [ :aMethod | ^ aMethod ]
		ifNone: [  ].

	self definition instanceSideDefinition traits do: [ :eachTrait |
		eachTrait methods
			methodNamed: aSelector
			ifFound: [ :aMethod | ^ aMethod ]
			ifNone: [  ] ].
		
	^ nil
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodNamedSelectorOrNil: aSelector [
	"Find any method with a given selector"
	<return: #GtPharoMethodDefinition>
	
	^ (self anyMethodNamedOrNil: aSelector)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodWithPragmaNamed: aPragmaName [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	KeyNotFound signalFor: aPragmaName in: self
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodWithPragmaNamed: aPragmaName andValue: aPragmaValue [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.) and its value"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	KeyNotFound signalFor: aPragmaName in: self
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodWithPragmaNamedOrNil: aPragmaName [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	^ nil
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.) and its value"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	^ nil
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> childViewModelsName [
	^ self metamodel childViewModelsName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> children [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>

	^ self metamodel children collect: [ :eachChildMetamodelWithDefinition |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachChildMetamodelWithDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> definition [
	^ definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> derives [
	^ self metamodel derives
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> elementViewModelSetterMethodDo: aFoundBlock ifNone: ifNoneBlock [
	self extraDefinitions do: [ :each | ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> environment [
	<return: #GtPharoEnvironment>

	^ self definition environment
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitionNamed: aName [
	^ self extraDefinitions
		detect: [ :eachDefinition | eachDefinition name = aName ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitions [
	^ extraDefinitions
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitions: anObject [
	extraDefinitions := anObject asOrderedCollection
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> forOneModel [
	<return: #GtRobocoderMetamodelWithCodeDefinition>

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self metamodel forOneModel
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> fullName [
	^ self metamodel fullName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> hasDeriveOfClass: aDeriveClass [
	^ self metamodel hasDeriveOfClass: aDeriveClass
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> hasParents [
	^ self metamodel hasParents
]

{ #category : #initialization }
GtRobocoderMetamodelWithCodeDefinition >> initialize [
	super initialize.
	
	extraDefinitions := OrderedCollection new.
	subscriptions := OrderedDictionary new
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForMany [
	^ self metamodel isForMany
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForOne [
	^ self metamodel isForOne
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeBehaviorDefinition: aBehaviorDefinition [
	self metamodel
		mergeBehaviorDefinition: aBehaviorDefinition
		into: self definition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeFullClassDefinition: aFullClassDefinition [
	self metamodel
		mergeFullClassDefinition: aFullClassDefinition
		into: self definition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeTemplateTrait: aTrait mappings: aCollectionOfAssociations [
	| aDefinition |

	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: aTrait;
		mappings: aCollectionOfAssociations;
		generate.

	self mergeBehaviorDefinition: aDefinition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeTemplateTraits: aTaSequence mappings: aCollectionOfAssociations [
	aTaSequence members do: [ :eachTrait |
		self
			mergeTemplateTrait: eachTrait
			mappings: aCollectionOfAssociations ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> metamodel [
	<return: #GtRobocoderMetamodel>

	^ viewModelModel
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> metamodel: aGtRobocoderMetamodel [
	viewModelModel := aGtRobocoderMetamodel
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self class
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inBehaviorDefinition: aBehaviorDefinition
		do: aFoundBlock
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			andValue: aPragmaValue
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inBehaviorDefinition: aViewModelBehaviorDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode | aFoundBlock value: eachMethod ] ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		inBehaviorDefinition: aViewModelBehaviorDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> name [
	^ self metamodel name
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> objectClassName [
	^ self metamodel objectClassName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> package [
	^ self metamodel package
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parent [
	<return: #GtRobocoderMetamodelWithCodeDefinition>

	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self metamodel parent
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelGetterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelGetter:
		andValue: aParentViewModelModel name
]

{ #category : #'api - selectors' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelGetterSelectorFor: aParentViewModelModel [
	<return: #Symbol>

	^ (self parentViewModelGetterMethodFor: aParentViewModelModel) selector
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelSelectorName [
	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self metamodel parentViewModelSelectorName
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelSetterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentObjectSetter:
		andValue: aParentViewModelModel name
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelTesterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelTester:
		andValue: aParentViewModelModel name
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parents [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>
	
	^ self metamodel parents collect: [ :eachParentViewModelModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachParentViewModelModel ]
]

{ #category : #copying }
GtRobocoderMetamodelWithCodeDefinition >> postCopy [
	definition := definition copy
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> prefix [
	^ self metamodel prefix
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> project [
	^ self metamodel project
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> properties [
	^ self metamodel properties
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> subscriptions [
	^ subscriptions
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> suffix [
	^ self metamodel suffix
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> tag [
	^ self metamodel tag
]
