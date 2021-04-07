Class {
	#name : #GtNavigationViewModelModelAnnotationNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitModelAnnotation: self
]

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelModelAnnotationNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> tokenVariables [
	^ #(#name)
]
