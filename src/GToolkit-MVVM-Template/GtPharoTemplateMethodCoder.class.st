Class {
	#name : #GtPharoTemplateMethodCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'templateMethod',
		'bindings'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #converting }
GtPharoTemplateMethodCoder >> asCoderUIModel [
	^ GtPharoTemplateMethodCoderViewModel new coderModel: self
]

{ #category : #'api - actions' }
GtPharoTemplateMethodCoder >> compileInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>
	
	"can not save is selector is nil"
	templateMethod storageSelector
		ifNil: [ ^ false ].

	^ templateMethod storageBehavior
		realBehaviorDo: [ :aBehavior |
			| aChange |
			aChange := self createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext.

			(self
				handleCompilerErrorsDuring: [ GtPharoCodeModifier current performRefactoryChange: aChange ])
				ifFalse: [ ^ false ].
			true ]

		ifAbsent: [ false ]
]

{ #category : #'api - ast' }
GtPharoTemplateMethodCoder >> computeAst: theSourceString [
	^ GtPharoTemplateParser
		parseWithErrors: theSourceString
		startingAt: GtPharoTemplateParser startingStateForMethod
]

{ #category : #'private - actions' }
GtPharoTemplateMethodCoder >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := self class new
		forCompiledMethod: GtPharoTemplateMethod class >> #storageMethodTemplate;
		mappings: {
			#storageSelector -> templateMethod storageSelector asString.
			#sourceCode -> self currentSourceString.
			#protocol -> templateMethod protocol
		};
		translate.

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ templateMethod protocol
		ifNil: [
			RBAddMethodChange
				compile: aSourceString
				in: aBehavior
				for: aGtPharoSourceCoderEvaluationContext ]
		ifNotNil: [ :aCategory | 
			RBAddMethodChange
				compile: aSourceString
				in: aBehavior
				classified: aCategory
				for: aGtPharoSourceCoderEvaluationContext ]
]

{ #category : #initialize }
GtPharoTemplateMethodCoder >> forCompiledMethod: aCompiledMethod [
	templateMethod := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ].
	self sourceCode: (GtCoderExplicitSourceCode new source: templateMethod sourceCode)
]

{ #category : #accessing }
GtPharoTemplateMethodCoder >> forMethod: aCompiledMethod [
	self forCompiledMethod: aCompiledMethod
]

{ #category : #initialize }
GtPharoTemplateMethodCoder >> forSource: aString [
	templateMethod := GtPharoTemplateMethod new
		sourceCode: aString.

	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]

{ #category : #initialize }
GtPharoTemplateMethodCoder >> forTemplateBehavior: aBehavior selector: aTemplateSelector [
	| aTemplateString |

	aTemplateString := aBehavior
		compiledMethodAt: aTemplateSelector
		ifPresent: [ :aCompiledMethod | ^ self forCompiledMethod: aCompiledMethod ]
		ifAbsent: [ 'method' ].

	templateMethod := GtPharoTemplateMethod new
		sourceCode: aTemplateString;
		storageBehavior: aBehavior selector: aTemplateSelector
]

{ #category : #'private - actions' }
GtPharoTemplateMethodCoder >> handleCompilerErrorsDuring: aBlock [
	^ [
			aBlock value.
			true ]
		on: OCSemanticWarning
		do: [ :ex | 
			self
				notifyParseError: ex errorMessage
				at: ex location.
			ex return: false ]
]

{ #category : #accessing }
GtPharoTemplateMethodCoder >> highlighter: anObject [
]

{ #category : #initialize }
GtPharoTemplateMethodCoder >> initialize [
	super initialize.

	bindings := GtSnippetBindings new.
	templateMethod := GtPharoTemplateMethod new
		sourceCode: ''
]

{ #category : #initialization }
GtPharoTemplateMethodCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

	addOns addStyler: GtPharoTemplateStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.

	addOns
		addMainAction: (GtCoderActivatableAction new
			id: GtMethodCoderSaveActionId;
			title: 'Save' translated;
			icon: BrGlamorousVectorIcons accept;
			action: [ :aCoderUIModel :anEvent | aCoderUIModel save ];
			updateWhen: GtMethodCoderSaveAbilityChanged).

	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.

	addOns
		addDropDownAction: 'Bindings'
		icon: BrGlamorousVectorIcons hamburger
		stencil: [
			| aContainer |
			aContainer := BrVerticalPane new
				hExact: 300;
				vFitContent.
			GtPhlowColumnedListView new
				column: 'Name'
					item: [ :each | each key asSymbol printString asRopedText ];
				column: 'Value'
					item: [ :each | each value printString ];
				items: [ bindings asDictionary associations sorted: [ :a :b | a key < b key ] ];
				asElementDo: [ :aList | aContainer addChild: aList ].
			aContainer ].

	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
]

{ #category : #accessing }
GtPharoTemplateMethodCoder >> isForMethod: aCompiledMethod [
	templateMethod storageBehavior realBehaviorDo: [ :aBehavior |
		^ aBehavior = aCompiledMethod methodClass
			and: [ templateMethod storageSelector = aCompiledMethod selector ] ].
	^ false
]

{ #category : #'api - accessing' }
GtPharoTemplateMethodCoder >> map: aVariableName to: anObject [
	bindings at: aVariableName put: anObject
]

{ #category : #'api - accessing' }
GtPharoTemplateMethodCoder >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #'private - actions' }
GtPharoTemplateMethodCoder >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ GtPharoTemplateTranslator new
		evaluationContext: aGtPharoSourceCoderEvaluationContext;
		bindings: bindings;
		processString: aSourceString
]

{ #category : #'api - actions' }
GtPharoTemplateMethodCoder >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	(self compileInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #'api - actions' }
GtPharoTemplateMethodCoder >> translate [
	<return: #String>

	^ self doItAll value
]
