Class {
	#name : #GtNavigationViewModelGenericPropertyNode,
	#superclass : #GtNavigationViewModelPropertyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelGenericPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGenericProperty: self
]
