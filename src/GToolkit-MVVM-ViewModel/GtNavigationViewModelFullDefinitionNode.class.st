Class {
	#name : #GtNavigationViewModelFullDefinitionNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'hierarchy',
		'definitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFullDefinition: self
]

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> definitions: aGtNavigationViewModelDefinitionsNode [
	self definitions notNil
		ifTrue: [ self definitions parent: nil ].
	definitions := aGtNavigationViewModelDefinitionsNode.
	self definitions notNil
		ifTrue: [ self definitions parent: self ]
]

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> hierarchy [
	^ hierarchy
]

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> hierarchy: aGtNavigationViewModelHierarchyNode [
	self hierarchy notNil
		ifTrue: [ self hierarchy parent: nil ].
	hierarchy := aGtNavigationViewModelHierarchyNode.
	self hierarchy notNil
		ifTrue: [ self hierarchy parent: self ]
]

{ #category : #generated }
GtNavigationViewModelFullDefinitionNode >> nodeVariables [
	^ #(#hierarchy #definitions)
]
