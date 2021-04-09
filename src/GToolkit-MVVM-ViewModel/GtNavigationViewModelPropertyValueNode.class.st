Class {
	#name : #GtNavigationViewModelPropertyValueNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyValue: self
]

{ #category : #accessing }
GtNavigationViewModelPropertyValueNode >> literalValue [
	^ self value source
]

{ #category : #generated }
GtNavigationViewModelPropertyValueNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtNavigationViewModelPropertyValueNode >> value [
	^ value
]

{ #category : #generated }
GtNavigationViewModelPropertyValueNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
