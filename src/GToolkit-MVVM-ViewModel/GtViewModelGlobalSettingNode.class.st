Class {
	#name : #GtViewModelGlobalSettingNode,
	#superclass : #GtViewModelSettingNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelGlobalSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGlobalSetting: self
]

{ #category : #accessing }
GtViewModelGlobalSettingNode >> literalValue [
	^ super literalValue asSymbol
]
