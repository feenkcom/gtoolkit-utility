Class {
	#name : #GtRobocoderMetamodelModelAnnotationNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'name',
		'api'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitModelAnnotation: self
]

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> api [
	^ api
]

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> api: aSmaCCToken [
	api := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelModelAnnotationNode >> apiNameString [
	<return: #String>

	^ (self api ifNil: [ ^ nil ]) source asSymbol
]

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> name [
	^ name
]

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelModelAnnotationNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtRobocoderMetamodelModelAnnotationNode >> tokenVariables [
	^ #(#name #api)
]
