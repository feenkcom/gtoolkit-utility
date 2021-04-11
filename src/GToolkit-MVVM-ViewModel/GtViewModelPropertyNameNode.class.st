Class {
	#name : #GtViewModelPropertyNameNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelPropertyNameNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyName: self
]

{ #category : #generated }
GtViewModelPropertyNameNode >> name [
	^ name
]

{ #category : #generated }
GtViewModelPropertyNameNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtViewModelPropertyNameNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtViewModelPropertyNameNode >> tokenVariables [
	^ #(#name)
]
