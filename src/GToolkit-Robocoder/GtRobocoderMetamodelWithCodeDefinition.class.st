Class {
	#name : #GtRobocoderMetamodelWithCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'viewModelModel',
		'definition',
		'extraDefinitions',
		'allViewModelModelDefinitions'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinition: aGtCodeDefinition [
	extraDefinitions add: aGtCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinitions: aCollectionOfGtCodeDefinition [
	extraDefinitions addAll: aCollectionOfGtCodeDefinition
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
GtRobocoderMetamodelWithCodeDefinition >> alreadyHasViewModel [
	^ self viewModelModel alreadyHasViewModel
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

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> childViewModelsName [
	^ self viewModelModel childViewModelsName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> children [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>

	^ self viewModelModel children collect: [ :eachChildViewModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachChildViewModel ]
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
	^ self viewModelModel derives
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> elementViewModelSetterMethodDo: aFoundBlock ifNone: ifNoneBlock [
	self extraDefinitions do: [ :each | ]
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

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel forOneModel
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> hasParents [
	^ self viewModelModel hasParents
]

{ #category : #initialization }
GtRobocoderMetamodelWithCodeDefinition >> initialize [
	super initialize.
	
	extraDefinitions := OrderedCollection new
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForMany [
	^ self viewModelModel isForMany
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForOne [
	^ self viewModelModel isForOne
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
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
GtRobocoderMetamodelWithCodeDefinition >> modelGetterSelector [
	^ self viewModelModel modelGetterSelector
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> name [
	^ self viewModelModel name
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parent [
	<return: #GtRobocoderMetamodelWithCodeDefinition>

	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel parent
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

	^ self viewModelModel parentViewModelSelectorName
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelSetterMethodFor: aParentViewModelModel [
	^ self
		anyMethodWithPragmaNamed: #parentViewModelSetter:
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
	
	^ self viewModelModel parents collect: [ :eachParentViewModelModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachParentViewModelModel ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> viewModelModel [
	<return: #GtRobocoderMetamodel>

	^ viewModelModel
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> viewModelModel: anObject [
	viewModelModel := anObject
]
