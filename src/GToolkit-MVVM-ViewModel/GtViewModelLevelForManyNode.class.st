Class {
	#name : #GtViewModelLevelForManyNode,
	#superclass : #GtViewModelSimpleLevelNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelLevelForManyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForMany: self
]

{ #category : #accessing }
GtViewModelLevelForManyNode >> fullNameString [
	^ self nameString, self suffix source
]

{ #category : #generated }
GtViewModelLevelForManyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtViewModelLevelForManyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtViewModelLevelForManyNode >> tokenVariables [
	^ #(#suffix #name)
]
