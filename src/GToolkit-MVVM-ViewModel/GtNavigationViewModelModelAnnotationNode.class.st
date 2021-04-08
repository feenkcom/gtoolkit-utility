Class {
	#name : #GtNavigationViewModelModelAnnotationNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'name',
		'api'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitModelAnnotation: self
]

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> api [
	^ api
]

{ #category : #generated }
GtNavigationViewModelModelAnnotationNode >> api: aSmaCCToken [
	api := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelModelAnnotationNode >> apiNameString [
	<return: #String>

	^ (self api ifNil: [ ^ nil ]) source asSymbol
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
	^ #(#name #api)
]
