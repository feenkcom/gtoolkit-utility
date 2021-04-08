Class {
	#name : #GtNavigationViewModelNamePropertyNode,
	#superclass : #GtNavigationViewModelPropertyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelNamePropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNameProperty: self
]
