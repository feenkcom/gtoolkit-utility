Class {
	#name : #GtNavigationViewModelHierarchyErrorNode,
	#superclass : #GtNavigationViewModelHierarchyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelHierarchyErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchyError: self
]
