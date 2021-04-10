Class {
	#name : #GtViewModelDefinitionNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'level',
		'model',
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinition: self
]

{ #category : #accessing }
GtViewModelDefinitionNode >> fullNameString [
	^ self level fullNameString
]

{ #category : #generated }
GtViewModelDefinitionNode >> level [
	^ level
]

{ #category : #generated }
GtViewModelDefinitionNode >> level: aGtViewModelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtViewModelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtViewModelDefinitionNode >> model [
	^ model
]

{ #category : #generated }
GtViewModelDefinitionNode >> model: aGtViewModelModelAnnotationNode [
	self model notNil
		ifTrue: [ self model parent: nil ].
	model := aGtViewModelModelAnnotationNode.
	self model notNil
		ifTrue: [ self model parent: self ]
]

{ #category : #generated }
GtViewModelDefinitionNode >> nodeVariables [
	^ #(#level #model #properties)
]

{ #category : #generated }
GtViewModelDefinitionNode >> properties [
	^ properties
]

{ #category : #generated }
GtViewModelDefinitionNode >> properties: aGtViewModelPropertiesNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtViewModelPropertiesNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]
