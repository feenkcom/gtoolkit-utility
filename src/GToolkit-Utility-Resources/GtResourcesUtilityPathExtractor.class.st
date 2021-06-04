"
I receive a code snippet string and return a {{gtClass:Path}} as a result of the code snippet.
My main method to use is {{gtMethod:GtResourcesUtilityPathExtractor>>#canEvaluate:}}. 

1. # Valid Code Snippets


The following code snippet {{gtExample:GtResourcesUtilityPathExtractorExamples>>#permitedLongPathString|label=#yourself}} is evaluated and I return:
{{gtExample:GtResourcesUtilityPathExtractorExamples>>#permitedLongPath|codeExpanded=false|previewExpanded=true}}

1. # Invalid Code Snippets


Only snippets with reference to {{gtClass:Path}}, string literals, and `*` and `/` messages are valid.

For example, the {{gtExample:GtResourcesUtilityPathExtractorExamples>>#unwantedUnarySender2String|label=#yourself}} is not evaluated and I return `nil` instead: 
{{gtExample:GtResourcesUtilityPathExtractorExamples>>#unwantedUnarySender2}}


"
Class {
	#name : #GtResourcesUtilityPathExtractor,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Support'
}

{ #category : #testing }
GtResourcesUtilityPathExtractor >> canEvaluate: aString [
	<return: #Boolean>
	| anAst |
	anAst := RBParser 
		parseExpression: aString
		onError: [ :theString :aPosition | ^ false ].
	(anAst allVariables allSatisfy: [ :eachNode | eachNode name = Path name ]) ifFalse: [ ^ false ].
	(anAst sentMessages allSatisfy: [ :eachSymbol | #(* /) includes: eachSymbol ]) ifFalse: [ ^ false ].
	anAst superMessages ifNotEmpty: [ ^ false ].
	anAst selfMessages ifNotEmpty: [ ^ false ].
	(anAst allChildren select: [ :eachNode | 
		eachNode isLiteralNode and: [ eachNode value isString not ] ]) ifNotEmpty: [ ^ false ].
	^ true
]

{ #category : #evaluating }
GtResourcesUtilityPathExtractor >> evaluate: aString [
	<return: #Path>
	^ [ 
		| aPath |
		aPath := self class compiler 
			source: aString;
			receiver: nil;
			requestor: self;
			failBlock: [ nil ];
			evaluate.
		(aPath isKindOf: Path)
			ifTrue: [ aPath ]
			ifFalse: [ nil ].
	] on: Error do: [ :anException | nil ]
]

{ #category : #'interactive error protocol' }
GtResourcesUtilityPathExtractor >> notify: aString at: anInteger in: aString3 [ 
	"do nothing"
]

{ #category : #accessing }
GtResourcesUtilityPathExtractor >> pathFrom: aString [
	<return: #Path>
	(self canEvaluate: aString) ifFalse: [ ^ nil ].
	^ self evaluate: aString
]
