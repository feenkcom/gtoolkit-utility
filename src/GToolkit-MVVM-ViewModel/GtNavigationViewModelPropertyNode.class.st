Class {
	#name : #GtNavigationViewModelPropertyNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperty: self
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> name: aGtNavigationViewModelPropertyNameNode [
	self name notNil
		ifTrue: [ self name parent: nil ].
	name := aGtNavigationViewModelPropertyNameNode.
	self name notNil
		ifTrue: [ self name parent: self ]
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> nodeVariables [
	^ #(#name #value)
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> value [
	^ value
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> value: aGtNavigationViewModelSymbolPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtNavigationViewModelSymbolPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
