Class {
	#name : #GtViewModelProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
