Class {
	#name : #GtViewModelSimpleLevelNode,
	#superclass : #GtViewModelLevelNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSimpleLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSimpleLevel: self
]

{ #category : #accessing }
GtViewModelSimpleLevelNode >> fullNameString [
	<return: #String>

	^ self nameString
]

{ #category : #generated }
GtViewModelSimpleLevelNode >> name [
	^ name
]

{ #category : #generated }
GtViewModelSimpleLevelNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtViewModelSimpleLevelNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtViewModelSimpleLevelNode >> tokenVariables [
	^ #(#name)
]
