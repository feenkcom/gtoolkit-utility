Class {
	#name : #GtViewModelDefinitionsNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'definitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelDefinitionsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinitions: self
]

{ #category : #generated }
GtViewModelDefinitionsNode >> compositeNodeVariables [
	^ #(#definitions)
]

{ #category : #generated }
GtViewModelDefinitionsNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtViewModelDefinitionsNode >> definitions: anOrderedCollection [
	self setParents: self definitions to: nil.
	definitions := anOrderedCollection.
	self setParents: self definitions to: self
]

{ #category : #'generated-initialize-release' }
GtViewModelDefinitionsNode >> initialize [
	super initialize.
	definitions := OrderedCollection new: 2.
]
