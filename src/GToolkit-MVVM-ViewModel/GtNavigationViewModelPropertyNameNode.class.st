Class {
	#name : #GtNavigationViewModelPropertyNameNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'name',
		'suffix'
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

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtNavigationViewModelPropertyNameNode >> tokenVariables [
	^ #(#name #suffix)
]
