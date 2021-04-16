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
			#storageProtocol -> templateMethod storageProtocol.
			#sourceCode -> self currentSourceString.
			#protocol -> templateMethod protocol
		};
		translate.

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ templateMethod storageProtocol
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

{ #category : #initialization }
GtPharoTemplateMethodCoder >> forCompiledMethod: aCompiledMethod [
	| aTemplateMethod |
	aTemplateMethod := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [
			aCompiledMethod methodClass isTrait
				ifTrue: [ Object new withArgs: { } executeMethod: aCompiledMethod ]
				ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ] ].

	self forTemplateMethod: aTemplateMethod
]

{ #category : #initialization }
GtPharoTemplateMethodCoder >> forMethod: aCompiledMethod [
	self forCompiledMethod: aCompiledMethod
]

{ #category : #initialization }
GtPharoTemplateMethodCoder >> forSource: aString [	
	self forTemplateMethod: (GtPharoTemplateMethod new sourceCode: aString)
]

{ #category : #initialization }
GtPharoTemplateMethodCoder >> forTemplateBehavior: aBehavior selector: aTemplateSelector [
	| aTemplateString |

	aTemplateString := aBehavior
		compiledMethodAt: aTemplateSelector
		ifPresent: [ :aCompiledMethod | ^ self forCompiledMethod: aCompiledMethod ]
		ifAbsent: [ 'method' ].

	self forTemplateMethod: (GtPharoTemplateMethod new
		sourceCode: aTemplateString;
		storageBehavior: aBehavior selector: aTemplateSelector)
]

{ #category : #initialization }
GtPharoTemplateMethodCoder >> forTemplateMethod: aGtPharoTemplateMethod [
	templateMethod := aGtPharoTemplateMethod.
	self sourceCode: (GtCoderExplicitSourceCode new source: templateMethod sourceCode)
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

{ #category : #initialization }
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

{ #category : #testing }
GtPharoTemplateMethodCoder >> isForClass [
	^ false
]

{ #category : #testing }
GtPharoTemplateMethodCoder >> isForMethod [
	^ true
]

{ #category : #accessing }
GtPharoTemplateMethodCoder >> isForMethod: aCompiledMethod [
	templateMethod storageBehavior realBehaviorDo: [ :aBehavior |
		^ aBehavior = aCompiledMethod methodClass
			and: [ templateMethod storageSelector = aCompiledMethod selector ] ].
	^ false
]

{ #category : #testing }
GtPharoTemplateMethodCoder >> isForPackage [
	^ false
]

{ #category : #testing }
GtPharoTemplateMethodCoder >> isForPackageTag [
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
	| aTranslatedMethodCode aTranslatedAst |
	
	aTranslatedMethodCode := GtPharoTemplateTranslator new
		evaluationContext: aGtPharoSourceCoderEvaluationContext;
		bindings: bindings;
		processString: aSourceString.

	aTranslatedAst := GtPharoParser
		parseWithErrors: aTranslatedMethodCode
		startingAt: GtPharoParser startingStateForMethod.
	
	templateMethod storageBehavior behaviorNameDo: [ :aBehaviorName |
		templateMethod storageSelector ifNotNil: [ :aSelector |
			| aGeneratedPragmaIndex |

			aGeneratedPragmaIndex := aTranslatedAst body pragmas
				ifEmpty: [
					"if stopPosition is zero mean thee is no body"
					aTranslatedAst body stopPosition > 0
						ifTrue: [ aTranslatedAst body startPosition ]
						ifFalse: [
							(aTranslatedAst comments notNil and: [ aTranslatedAst comments notEmpty ])
								ifTrue: [ aTranslatedAst comments last second ]
								ifFalse: [ aTranslatedAst stopPosition ] ] ]
				ifNotEmpty: [ :thePragmas | thePragmas last stopPosition ].

			aTranslatedMethodCode := String streamContents: [ :aStream |
				aStream nextPutAll: (aTranslatedMethodCode
					copyFrom: 1
					to: aGeneratedPragmaIndex).
				aStream cr; tab.
				aStream
					nextPutAll: '<generatedFrom: #';
					nextPut: $';
					nextPutAll: aBehaviorName;
					nextPutAll: '>>#';
					nextPutAll: aSelector;
					nextPut: $';
					nextPut: $>.

				aStream nextPutAll: (aTranslatedMethodCode
					copyFrom: aGeneratedPragmaIndex + 1
					to: aTranslatedMethodCode size) ]
		].
	].

	^ aTranslatedMethodCode
]

{ #category : #'api - accessing' }
GtPharoTemplateMethodCoder >> protocol [
	"Return a generated method protocol name, the returned protocol is never nil.
	The default value is `generated`"
	<return: #String>

	^ GtPharoTemplateTranslator new
		evaluationContext: self evaluationContext;
		bindings: bindings;
		processString: (templateMethod protocol ifNil: [ 'generated' ])
]

{ #category : #'api - actions' }
GtPharoTemplateMethodCoder >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	(self compileInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
GtPharoTemplateMethodCoder >> theClass [
	^ templateMethod storageBehavior
		realBehaviorDo: [ :aBehavior | aBehavior ]
		ifAbsent: [ UndefinedObject ]
]

{ #category : #'api - actions' }
GtPharoTemplateMethodCoder >> translate [
	<return: #String>
	
	^ self doItAll value
]
