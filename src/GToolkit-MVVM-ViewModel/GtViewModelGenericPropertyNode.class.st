Class {
	#name : #GtViewModelGenericPropertyNode,
	#superclass : #GtViewModelPropertyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelGenericPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGenericProperty: self
]
