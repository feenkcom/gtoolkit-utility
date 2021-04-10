Class {
	#name : #GtViewModelGlobalPropertyValueNode,
	#superclass : #GtViewModelPropertyValueNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelGlobalPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGlobalPropertyValue: self
]
