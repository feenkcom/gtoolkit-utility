Class {
	#name : #GtNavigationViewModelLevelNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevel: self
]

{ #category : #testing }
GtNavigationViewModelLevelNode >> isCompositeLevel [
	^ false
]
