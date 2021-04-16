Class {
	#name : #GtPharoTemplateOnlyParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyParser class >> ambiguousTransitions [
^#(
#[ 0 26 0 49]
	).
]

{ #category : #'generated-accessing' }
GtPharoTemplateOnlyParser class >> cacheId [
	^'2021-04-15T15:40:13.204427+02:00'
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtPharoTemplateOnly;
%suffix Node;
<name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
<leftBrace>
	: \{
	;
<rightBrace>
	: \}
	;
<stringSegment>
	: ([^\{\}])+
	;
Start 
	: TemplateContent
	;
TemplateContent
	: TemplateCode'templatePart' {{}}
	| (TemplateCode'templatePart'Template'templatePart'TemplateCode 'templatePart')+ {{}}
	;
Template
	: <leftBrace>'leftBrace'TemplateContent'content'<rightBrace>'rightBrace' {{}}
	;
TemplateCode
	: <stringSegment>'string'* {{}}
	;"
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> reduceTable [
^#(
	#(11 0 #reduceActionFor_stringSegment__string__1: 494593 false ) 
	#(5 1 #liftFirstValue: 210945 false ) 
	#(8 1 #reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart___1: 295937 false ) 
	#(6 1 #reduceActionForTemplateContent2: 240642 false ) 
	#(6 1 #reduceActionForTemplateContent1: 240641 false ) 
	#(10 1 #reduceActionForTemplateCode1: 478209 false ) 
	#(8 2 #reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart___2: 295938 false ) 
	#(11 2 #reduceActionFor_stringSegment__string__2: 494594 false ) 
	#(7 3 #reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart__1: 295937 false ) 
	#(9 3 #reduceActionForTemplate1: 385025 false )
	).
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> scannerClass [
	^GtPharoTemplateOnlyScanner
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> startingStateForStart [
	^ 1
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<stringSegment>' 'B e g i n' 'Start' 'TemplateContent' '(TemplateCode''templatePart''Template''templatePart''TemplateCode ''templatePart'')' '(TemplateCode''templatePart''Template''templatePart''TemplateCode ''templatePart'')+' 'Template' 'TemplateCode' '<stringSegment>''string''*' 'E O F' 'error')
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #GtPharoTemplateOnlyTemplateContentNode #GtPharoTemplateOnlyTemplateContentNode #GtPharoTemplateOnlyTemplateContentNode #OrderedCollection #OrderedCollection #GtPharoTemplateOnlyTemplateNode #GtPharoTemplateOnlyTemplateCodeNode #OrderedCollection #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoTemplateOnlyParser class >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 3 0 9 0 5 0 9 0 6 0 17 0 7 0 21 0 8 0 25 0 10 0 29 0 11 0 6 0 12] 
#[0 0 0 0 12] 
#[0 0 10 0 12] 
#[0 0 14 0 1 0 2 0 3 0 12] 
#[1 0 6 0 1 0 18 0 2 0 6 0 3 0 33 0 7 0 37 0 10 0 29 0 11 0 18 0 12] 
#[1 0 41 0 1 0 22 0 2 0 45 0 9 0 22 0 12] 
#[1 0 26 0 1 0 26 0 2 0 7 0 3 0 26 0 12] 
#[0 0 30 0 1 0 2 0 3 0 12] 
#[1 0 41 0 1 0 45 0 9] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 53 0 6 0 17 0 7 0 21 0 8 0 25 0 10 0 29 0 11] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 57 0 10 0 29 0 11 0 6 0 12] 
#[0 0 34 0 1 0 2 0 3 0 12] 
#[0 0 61 0 2] 
#[0 0 38 0 1 0 2 0 3 0 12] 
#[0 0 42 0 1 0 2 0 3 0 12]
	).
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionForTemplate1: nodes [
	| result |
	result := GtPharoTemplateOnlyTemplateNode new.
	result leftBrace: (nodes at: 1).
	result content: (nodes at: 2).
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionForTemplateCode1: nodes [
	| result |
	result := GtPharoTemplateOnlyTemplateCodeNode new.
	result addTokens: (nodes at: 1) to: result strings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionForTemplateContent1: nodes [
	| result |
	result := GtPharoTemplateOnlyTemplateContentNode new.
	result addNode: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionForTemplateContent2: nodes [
	| result |
	result := GtPharoTemplateOnlyTemplateContentNode new.
	result addNodes: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart___1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionFor_TemplateCode_templatePart_Template_templatePart_TemplateCode__templatePart___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionFor_stringSegment__string__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateOnlyParser >> reduceActionFor_stringSegment__string__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]
