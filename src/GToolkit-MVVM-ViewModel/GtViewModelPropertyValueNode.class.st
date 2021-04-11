Class {
	#name : #GtViewModelPropertyValueNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyValue: self
]

{ #category : #accessing }
GtViewModelPropertyValueNode >> literalValue [
	^ self value source
]

{ #category : #generated }
GtViewModelPropertyValueNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtViewModelPropertyValueNode >> value [
	^ value
]

{ #category : #generated }
GtViewModelPropertyValueNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
