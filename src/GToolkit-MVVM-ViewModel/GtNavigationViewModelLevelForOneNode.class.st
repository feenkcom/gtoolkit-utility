Class {
	#name : #GtNavigationViewModelLevelForOneNode,
	#superclass : #GtNavigationViewModelSimpleLevelNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelLevelForOneNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForOne: self
]
