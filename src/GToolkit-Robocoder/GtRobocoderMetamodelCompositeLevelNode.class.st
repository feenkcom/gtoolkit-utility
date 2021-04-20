Class {
	#name : #GtRobocoderMetamodelCompositeLevelNode,
	#superclass : #GtRobocoderMetamodelLevelNode,
	#instVars : [
		'items',
		'and'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCompositeLevel: self
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> and [
	^ and
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> and: aSmaCCToken [
	and := aSmaCCToken
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelCompositeLevelNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
]

{ #category : #testing }
GtRobocoderMetamodelCompositeLevelNode >> isCompositeLevel [
	^ true
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> items [
	^ items
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> tokenVariables [
	^ #(#and)
]
