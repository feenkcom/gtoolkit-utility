Class {
	#name : #GtNavigationViewModelSimpleLevelNode,
	#superclass : #GtNavigationViewModelLevelNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelSimpleLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSimpleLevel: self
]

{ #category : #accessing }
GtNavigationViewModelSimpleLevelNode >> fullNameString [
	<return: #String>

	^ self nameString
]

{ #category : #generated }
GtNavigationViewModelSimpleLevelNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelSimpleLevelNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelSimpleLevelNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtNavigationViewModelSimpleLevelNode >> tokenVariables [
	^ #(#name)
]
