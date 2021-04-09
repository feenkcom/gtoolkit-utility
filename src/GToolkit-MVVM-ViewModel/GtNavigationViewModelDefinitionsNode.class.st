Class {
	#name : #GtNavigationViewModelDefinitionsNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'definitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelDefinitionsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinitions: self
]

{ #category : #generated }
GtNavigationViewModelDefinitionsNode >> compositeNodeVariables [
	^ #(#definitions)
]

{ #category : #generated }
GtNavigationViewModelDefinitionsNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtNavigationViewModelDefinitionsNode >> definitions: anOrderedCollection [
	self setParents: self definitions to: nil.
	definitions := anOrderedCollection.
	self setParents: self definitions to: self
]

{ #category : #'generated-initialize-release' }
GtNavigationViewModelDefinitionsNode >> initialize [
	super initialize.
	definitions := OrderedCollection new: 2.
]
