Class {
	#name : #GtViewModelSettingPropertyNode,
	#superclass : #GtViewModelPropertyNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSettingPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettingProperty: self
]
