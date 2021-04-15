Class {
	#name : #GtPharoTemplateOnlyTemplateCodeNode,
	#superclass : #GtPharoTemplateOnlyProgramNode,
	#instVars : [
		'strings'
	],
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyTemplateCodeNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateCode: self
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateCodeNode >> compositeTokenVariables [
	^ #(#strings)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateOnlyTemplateCodeNode >> initialize [
	super initialize.
	strings := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateCodeNode >> strings [
	^ strings
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateCodeNode >> strings: anOrderedCollection [
	strings := anOrderedCollection
]
