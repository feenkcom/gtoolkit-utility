Class {
	#name : #GtNavigationViewModelItemsPropertyNode,
	#superclass : #GtNavigationViewModelPropertyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelItemsPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitItemsProperty: self
]
