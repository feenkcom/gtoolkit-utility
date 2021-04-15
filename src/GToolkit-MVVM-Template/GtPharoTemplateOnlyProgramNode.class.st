Class {
	#name : #GtPharoTemplateOnlyProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
