Class {
	#name : #GtViewModelPropertiesNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelPropertiesNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperties: self
]

{ #category : #generated }
GtViewModelPropertiesNode >> compositeNodeVariables [
	^ #(#properties)
]

{ #category : #'generated-initialize-release' }
GtViewModelPropertiesNode >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #generated }
GtViewModelPropertiesNode >> properties [
	^ properties
]

{ #category : #generated }
GtViewModelPropertiesNode >> properties: anOrderedCollection [
	self setParents: self properties to: nil.
	properties := anOrderedCollection.
	self setParents: self properties to: self
]
