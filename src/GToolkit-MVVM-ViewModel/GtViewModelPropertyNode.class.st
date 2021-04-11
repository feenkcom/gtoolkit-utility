Class {
	#name : #GtViewModelPropertyNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperty: self
]

{ #category : #accessing }
GtViewModelPropertyNode >> literalValue [
	^ self value literalValue
]

{ #category : #generated }
GtViewModelPropertyNode >> name [
	^ name
]

{ #category : #generated }
GtViewModelPropertyNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #accessing }
GtViewModelPropertyNode >> nameString [
	^ self name nameString
]

{ #category : #generated }
GtViewModelPropertyNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtViewModelPropertyNode >> otherVariables [
	^ #(#name)
]

{ #category : #generated }
GtViewModelPropertyNode >> value [
	^ value
]

{ #category : #generated }
GtViewModelPropertyNode >> value: aGtViewModelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtViewModelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
