Class {
	#name : #GtViewModelModelAnnotationNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'name',
		'api'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelModelAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitModelAnnotation: self
]

{ #category : #generated }
GtViewModelModelAnnotationNode >> api [
	^ api
]

{ #category : #generated }
GtViewModelModelAnnotationNode >> api: aSmaCCToken [
	api := aSmaCCToken
]

{ #category : #accessing }
GtViewModelModelAnnotationNode >> apiNameString [
	<return: #String>

	^ (self api ifNil: [ ^ nil ]) source asSymbol
]

{ #category : #generated }
GtViewModelModelAnnotationNode >> name [
	^ name
]

{ #category : #generated }
GtViewModelModelAnnotationNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtViewModelModelAnnotationNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtViewModelModelAnnotationNode >> tokenVariables [
	^ #(#name #api)
]
