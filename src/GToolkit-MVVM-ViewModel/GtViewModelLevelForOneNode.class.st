Class {
	#name : #GtViewModelLevelForOneNode,
	#superclass : #GtViewModelSimpleLevelNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelLevelForOneNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForOne: self
]
