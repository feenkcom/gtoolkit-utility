Class {
	#name : #GtViewModelLocalSettingNode,
	#superclass : #GtViewModelSettingNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelLocalSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLocalSetting: self
]
