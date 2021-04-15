Class {
	#name : #GtPharoTemplateOnlyTemplateNode,
	#superclass : #GtPharoTemplateOnlyProgramNode,
	#instVars : [
		'leftBrace',
		'content',
		'rightBrace'
	],
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplate: self
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> content [
	^ content
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> content: aGtPharoTemplateOnlyTemplateContentNode [
	self content notNil
		ifTrue: [ self content parent: nil ].
	content := aGtPharoTemplateOnlyTemplateContentNode.
	self content notNil
		ifTrue: [ self content parent: self ]
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> leftBrace [
	^ leftBrace
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> leftBrace: aSmaCCToken [
	leftBrace := aSmaCCToken
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> nodeVariables [
	^ #(#content)
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> rightBrace [
	^ rightBrace
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> rightBrace: aSmaCCToken [
	rightBrace := aSmaCCToken
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateNode >> tokenVariables [
	^ #(#leftBrace #rightBrace)
]
