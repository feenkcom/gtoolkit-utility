Class {
	#name : #GtPharoTemplateTranslator,
	#superclass : #Object,
	#traits : 'TGtPharoTemplateOnlyProgramNodeVisitor',
	#classTraits : 'TGtPharoTemplateOnlyProgramNodeVisitor classTrait',
	#instVars : [
		'evaluationContext'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #accessing }
GtPharoTemplateTranslator >> bindings [
	^ self evaluationContext bindingStrategy bindings
]

{ #category : #accessing }
GtPharoTemplateTranslator >> bindings: theBindings [
	| aCopyOfBindings |
	
	aCopyOfBindings := GtSnippetBindings new.
	aCopyOfBindings at: #'__external_bindings__' put: aCopyOfBindings.
	
	theBindings asDictionary keysAndValuesDo: [ :eachKey :eachValue |
		aCopyOfBindings at: eachKey put: eachValue ].
	
	self evaluationContext bindingStrategy: (GtSnippetBindingStrategy new bindings: aCopyOfBindings)
]

{ #category : #translate }
GtPharoTemplateTranslator >> evaluateExpression: aSourceString [
	| aSnippetCoder aTemplateResult |

	aSnippetCoder := GtPharoSnippetCoder forSource: aSourceString.
	aTemplateResult := aSnippetCoder doItInContext: self evaluationContext.

	aTemplateResult isSuccess
		ifFalse: [ self error: 'Failed to generate a template' ].

	^ self evaluationResultToString: aTemplateResult value
]

{ #category : #accessing }
GtPharoTemplateTranslator >> evaluationContext [
	^ evaluationContext
]

{ #category : #accessing }
GtPharoTemplateTranslator >> evaluationContext: anObject [
	evaluationContext := anObject.
	self bindings: evaluationContext bindingStrategy bindings
]

{ #category : #'private - replacement' }
GtPharoTemplateTranslator >> evaluationResultToString: anObject [
	| aResult |

	aResult := anObject isString
		ifTrue: [ anObject ]
		ifFalse: [
			anObject isCollection
				ifTrue: [ String streamContents: [ :aStream | anObject do: [ :eachString | aStream nextPutAll: eachString asString ] ] ]
				ifFalse: [ anObject asString ] ].

	^ aResult
]

{ #category : #initialization }
GtPharoTemplateTranslator >> initialize [
	super initialize.

	evaluationContext := GtPharoSourceCoderEvaluationContext new.
	self bindings: GtSnippetBindings new
]

{ #category : #accessing }
GtPharoTemplateTranslator >> map: aVariableName to: anObject [
	self bindings at: aVariableName put: anObject
]

{ #category : #accessing }
GtPharoTemplateTranslator >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #'private - replacement' }
GtPharoTemplateTranslator >> processString: aSourceCode [
	| theTemplates theResultingSourceCode aSnippetCoder aTemplateResult |

	theTemplates := GtPharoTemplateOnlyParser parse: aSourceCode.
	theResultingSourceCode := self accept: theTemplates.

	aSnippetCoder := GtPharoSnippetCoder forSource: theResultingSourceCode.
	aTemplateResult := aSnippetCoder doItInContext: self evaluationContext.

	aTemplateResult isSuccess
		ifFalse: [ self error: 'Failed to generate a template' ].

	^ aTemplateResult value
]

{ #category : #accessing }
GtPharoTemplateTranslator >> runtimeContext: aContext [
	self evaluationContext runtimeContext: aContext.

	aContext tempNames do: [ :eachTempName |
		self bindings at: eachTempName put: (aContext tempNamed: eachTempName) ]
]

{ #category : #'private - replacement' }
GtPharoTemplateTranslator >> sourceForEmbeddedTemplateSource: aString [
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self class name;
			space;
			nextPutAll: 'new';
			space;
			nextPutAll: 'bindings: __external_bindings__;';
			space;
			nextPutAll: #runtimeContext:;
			space;
			nextPutAll: 'thisContext';
			nextPut: $;;
			space;
			nextPutAll: #evaluateExpression:;
			space;
			nextPutAll: aString ]
]

{ #category : #translate }
GtPharoTemplateTranslator >> translate: aGtPharoProgramNode [
	self accept: aGtPharoProgramNode.
	
	^ aGtPharoProgramNode completeSource asString
]

{ #category : #translate }
GtPharoTemplateTranslator >> translateExpression: aSourceString [
	| anExpressionAst |

	anExpressionAst := GtPharoTemplateParser
		parse: aSourceString
		startingAt: GtPharoTemplateParser startingStateForMethodSequence.
	
	^ self translate: anExpressionAst
]

{ #category : #translate }
GtPharoTemplateTranslator >> translateMethod: aSourceString [
	| anExpressionAst |

	anExpressionAst := GtPharoTemplateParser
		parse: aSourceString
		startingAt: GtPharoTemplateParser startingStateForMethod.
	
	^ self translate: anExpressionAst
]

{ #category : #generated }
GtPharoTemplateTranslator >> visitTemplate: aTemplate [
	| isRootTemplate |
	
	isRootTemplate := aTemplate allParents
		detect: [ :each | each isKindOf: GtPharoTemplateOnlyTemplateNode ]
		ifFound: [ false ]
		ifNone: [ true ].

	^ String streamContents: [ :aStream |
		isRootTemplate
			ifFalse: [ aStream nextPut: $( ].
		aStream
			nextPut: $(;
			nextPutAll: (self sourceForEmbeddedTemplateSource: (self accept: aTemplate content));
			nextPut: $).
		isRootTemplate
			ifFalse: [
				aStream
					nextPutAll: 'copyReplaceAll: '''''''' with: ''''''''''''';
					nextPut: $) ] ]
]

{ #category : #generated }
GtPharoTemplateTranslator >> visitTemplateCode: aTemplateCode [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: aTemplateCode source asString printString ]
]

{ #category : #generated }
GtPharoTemplateTranslator >> visitTemplateContent: aTemplateContent [
	^ String streamContents: [ :aStream |
		(aTemplateContent templateParts
			collect: [ :eachPart | self accept: eachPart ]
			thenSelect: [ :eachPartString | eachPartString notEmpty and: [ eachPartString ~= '''''' ] ])
				do: [ :eachPartString | aStream nextPutAll: eachPartString ]
				separatedBy: [ aStream nextPut: $, ] ]
]
