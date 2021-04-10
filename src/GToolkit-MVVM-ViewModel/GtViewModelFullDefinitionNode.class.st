Class {
	#name : #GtViewModelFullDefinitionNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'hierarchy',
		'settings',
		'definitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelFullDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFullDefinition: self
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> definitions: aGtViewModelDefinitionsNode [
	self definitions notNil
		ifTrue: [ self definitions parent: nil ].
	definitions := aGtViewModelDefinitionsNode.
	self definitions notNil
		ifTrue: [ self definitions parent: self ]
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> hierarchy [
	^ hierarchy
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> hierarchy: aGtViewModelHierarchyNode [
	self hierarchy notNil
		ifTrue: [ self hierarchy parent: nil ].
	hierarchy := aGtViewModelHierarchyNode.
	self hierarchy notNil
		ifTrue: [ self hierarchy parent: self ]
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> nodeVariables [
	^ #(#hierarchy #settings #definitions)
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> settings [
	^ settings
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> settings: aGtViewModelSettingsNode [
	self settings notNil
		ifTrue: [ self settings parent: nil ].
	settings := aGtViewModelSettingsNode.
	self settings notNil
		ifTrue: [ self settings parent: self ]
]
