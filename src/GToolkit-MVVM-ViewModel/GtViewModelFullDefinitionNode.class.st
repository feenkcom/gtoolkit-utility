Class {
	#name : #GtViewModelFullDefinitionNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'hierarchies',
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
GtViewModelFullDefinitionNode >> hierarchies [
	^ hierarchies
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> hierarchies: aGtViewModelHierarchiesNode [
	self hierarchies notNil
		ifTrue: [ self hierarchies parent: nil ].
	hierarchies := aGtViewModelHierarchiesNode.
	self hierarchies notNil
		ifTrue: [ self hierarchies parent: self ]
]

{ #category : #generated }
GtViewModelFullDefinitionNode >> nodeVariables [
	^ #(#hierarchies #settings #definitions)
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
