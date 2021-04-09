Class {
	#name : #GtNavigationViewModelGlobalPropertyValueNode,
	#superclass : #GtNavigationViewModelPropertyValueNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelGlobalPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGlobalPropertyValue: self
]
