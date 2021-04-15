Class {
	#name : #GtPharoTemplateOnlyScanner,
	#superclass : #SmaCCScanner,
	#instVars : [
		'templateDepth',
		'leftBraceDepth',
		'rightBraceDepth'
	],
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyScanner >> emptySymbolTokenId [
	^ 12
]

{ #category : #generated }
GtPharoTemplateOnlyScanner >> errorTokenId [
	^ 13
]

{ #category : #'initialize-release' }
GtPharoTemplateOnlyScanner >> initialize [
	super initialize.
	
	leftBraceDepth := 0.
	rightBraceDepth := 0.
	templateDepth := 0
]

{ #category : #actions }
GtPharoTemplateOnlyScanner >> leftBrace [
	| aNextToken |

	leftBraceDepth := leftBraceDepth + 1.
	leftBraceDepth = 2
		ifTrue: [
			| token |
			leftBraceDepth := 0.
			templateDepth := templateDepth + 1.
			token := self tokenClass
				value: '{{'
				start: (start max: 1)
				ids: matchActions.
			outputStream reset.
			^ token ].
	
	self atEnd
		ifTrue: [
			| token |
			
			token := self tokenClass
				value: '{'
				start: start + 1
				ids: #(3).
			self resetScanner.
			^ token ].
	
	self resetScanner.
	aNextToken := self scanForToken.

	aNextToken value = '{{'
		ifFalse: [
			leftBraceDepth := 0.
			rightBraceDepth := 0.
			aNextToken
				value: '{', aNextToken value
				start: aNextToken startPosition - 1
				ids: #(3).
			^ aNextToken ].

	^ aNextToken
]

{ #category : #actions }
GtPharoTemplateOnlyScanner >> rightBrace [
	| aNextToken |

	rightBraceDepth := rightBraceDepth + 1.
	rightBraceDepth = 2
		ifTrue: [
			| token |
			
			rightBraceDepth := 0.
			templateDepth := templateDepth - 1.
			token := self tokenClass
				value: '}}'
				start: start
				ids: matchActions.
			outputStream reset.
			^ token ].

	self atEnd
		ifTrue: [
			| token |
			
			token := self tokenClass
				value: '}'
				start: start + 1
				ids: #(3).
			self resetScanner.
			^ token ].	
	
	self resetScanner.
	aNextToken := self scanForToken.
	
	aNextToken value = '}}'
		ifFalse: [
			rightBraceDepth := 0.
			leftBraceDepth := 0.
			aNextToken
				value: '}', aNextToken value
				start: aNextToken startPosition - 1
				ids: #(3).
			^ aNextToken ].

	^ aNextToken
]

{ #category : #generated }
GtPharoTemplateOnlyScanner >> scanForToken [
	self step.
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	true
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter <= $z
				or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateOnlyScanner >> tokenActions [
	^ #(#leftBrace #rightBrace)
]
