Class {
	#name : #GtViewModelHierarchyErrorNode,
	#superclass : #GtViewModelHierarchyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelHierarchyErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchyError: self
]
