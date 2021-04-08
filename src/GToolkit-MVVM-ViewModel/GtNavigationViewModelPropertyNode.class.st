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

{ #category : #accessing }
GtNavigationViewModelPropertyNode >> literalValue [
	^ self value literalValue
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #accessing }
GtNavigationViewModelPropertyNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> otherVariables [
	^ #(#name)
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> value [
	^ value
]

{ #category : #generated }
GtNavigationViewModelPropertyNode >> value: aGtNavigationViewModelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtNavigationViewModelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
