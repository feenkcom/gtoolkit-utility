Class {
	#name : #GtRobocoderMetamodelDefinitionNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'level',
		'model',
		'properties'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinition: self
]

{ #category : #accessing }
GtRobocoderMetamodelDefinitionNode >> fullNameString [
	^ self level fullNameString
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> level [
	^ level
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> level: aGtRobocoderMetamodelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtRobocoderMetamodelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> model [
	^ model
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> model: aGtRobocoderMetamodelModelAnnotationNode [
	self model notNil
		ifTrue: [ self model parent: nil ].
	model := aGtRobocoderMetamodelModelAnnotationNode.
	self model notNil
		ifTrue: [ self model parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> nodeVariables [
	^ #(#level #model #properties)
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> properties [
	^ properties
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> properties: aGtRobocoderMetamodelPropertiesNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtRobocoderMetamodelPropertiesNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]
