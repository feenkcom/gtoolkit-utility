Class {
	#name : #GtRobocoderMetamodelLevelForManyNode,
	#superclass : #GtRobocoderMetamodelSimpleLevelNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelLevelForManyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForMany: self
]

{ #category : #accessing }
GtRobocoderMetamodelLevelForManyNode >> fullNameString [
	^ self nameString, self suffix source
]

{ #category : #generated }
GtRobocoderMetamodelLevelForManyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtRobocoderMetamodelLevelForManyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtRobocoderMetamodelLevelForManyNode >> tokenVariables [
	^ #(#suffix #name)
]
