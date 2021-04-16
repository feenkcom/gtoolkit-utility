Class {
	#name : #GtViewModelModelWithCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'viewModelModel',
		'definition',
		'extraDefinitions',
		'allViewModelModelDefinitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> addExtraDefinition: aGtCodeDefinition [
	extraDefinitions add: aGtCodeDefinition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> addExtraDefinitions: aCollectionOfGtCodeDefinition [
	extraDefinitions addAll: aCollectionOfGtCodeDefinition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> allViewModelModelDefinitions [
	^ allViewModelModelDefinitions
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> allViewModelModelDefinitions: anObject [
	allViewModelModelDefinitions := anObject
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> alreadyHasViewModel [
	^ self viewModelModel alreadyHasViewModel
]

{ #category : #'private - methods' }
GtViewModelModelWithCodeDefinition >> anyMethodWithPragmaNamed: aPragmaName [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	KeyNotFound signalFor: aPragmaName in: self
]

{ #category : #'private - methods' }
GtViewModelModelWithCodeDefinition >> anyMethodWithPragmaNamed: aPragmaName andValue: aPragmaValue [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.) and its value"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	KeyNotFound signalFor: aPragmaName in: self
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> childViewModelsName [
	^ self viewModelModel childViewModelsName
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> children [
	<return: #Collection of: #GtViewModelModelWithCodeDefinition>

	^ self viewModelModel children collect: [ :eachChildViewModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachChildViewModel ]
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> definition [
	^ definition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> derives [
	^ self viewModelModel derives
]

{ #category : #'api - methods' }
GtViewModelModelWithCodeDefinition >> elementViewModelSetterMethodDo: aFoundBlock ifNone: ifNoneBlock [
	self extraDefinitions do: [ :each | ]
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> extraDefinitions [
	^ extraDefinitions
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> extraDefinitions: anObject [
	extraDefinitions := anObject asOrderedCollection
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> forOneModel [
	<return: #GtViewModelModelWithCodeDefinition>

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel forOneModel
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> hasParents [
	^ self viewModelModel hasParents
]

{ #category : #initialization }
GtViewModelModelWithCodeDefinition >> initialize [
	super initialize.
	
	extraDefinitions := OrderedCollection new
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> isForMany [
	^ self viewModelModel isForMany
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> isForOne [
	^ self viewModelModel isForOne
]

{ #category : #'private - methods' }
GtViewModelModelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
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

{ #category : #'private - methods' }
GtViewModelModelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
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
GtViewModelModelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
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
GtViewModelModelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
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
GtViewModelModelWithCodeDefinition >> modelGetterSelector [
	^ self viewModelModel modelGetterSelector
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> name [
	^ self viewModelModel name
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> parent [
	<return: #GtViewModelModelWithCodeDefinition>

	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel parent
]

{ #category : #'api - methods' }
GtViewModelModelWithCodeDefinition >> parentViewModelGetterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelGetter:
		andValue: aParentViewModelModel name
]

{ #category : #'api - selectors' }
GtViewModelModelWithCodeDefinition >> parentViewModelGetterSelectorFor: aParentViewModelModel [
	<return: #Symbol>

	^ (self parentViewModelGetterMethodFor: aParentViewModelModel) selector
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> parentViewModelSelectorName [
	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self viewModelModel parentViewModelSelectorName
]

{ #category : #'api - methods' }
GtViewModelModelWithCodeDefinition >> parentViewModelSetterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelSetter:
		andValue: aParentViewModelModel name
]

{ #category : #'api - methods' }
GtViewModelModelWithCodeDefinition >> parentViewModelTesterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelTester:
		andValue: aParentViewModelModel name
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> parents [
	<return: #Collection of: #GtViewModelModelWithCodeDefinition>
	
	^ self viewModelModel parents collect: [ :eachParentViewModelModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachParentViewModelModel ]
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> viewModelModel [
	<return: #GtViewModelModel>

	^ viewModelModel
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> viewModelModel: anObject [
	viewModelModel := anObject
]
