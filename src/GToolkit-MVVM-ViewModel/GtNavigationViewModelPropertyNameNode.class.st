Class {
	#name : #GtNavigationViewModelPropertyNameNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyName: self
]

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelPropertyNameNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> tokenVariables [
	^ #(#name)
]
