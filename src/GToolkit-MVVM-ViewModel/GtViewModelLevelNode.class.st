Class {
	#name : #GtViewModelLevelNode,
	#superclass : #GtViewModelProgramNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevel: self
]

{ #category : #testing }
GtViewModelLevelNode >> isCompositeLevel [
	^ false
]
