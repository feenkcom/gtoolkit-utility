Class {
	#name : #GtNavigationViewModelDefinitionNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'level',
		'model',
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinition: self
]

{ #category : #accessing }
GtNavigationViewModelDefinitionNode >> fullNameString [
	^ self level fullNameString
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> level [
	^ level
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> level: aGtNavigationViewModelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtNavigationViewModelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> model [
	^ model
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> model: aGtNavigationViewModelModelAnnotationNode [
	self model notNil
		ifTrue: [ self model parent: nil ].
	model := aGtNavigationViewModelModelAnnotationNode.
	self model notNil
		ifTrue: [ self model parent: self ]
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> nodeVariables [
	^ #(#level #model #properties)
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> properties [
	^ properties
]

{ #category : #generated }
GtNavigationViewModelDefinitionNode >> properties: aGtNavigationViewModelPropertiesNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtNavigationViewModelPropertiesNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]
