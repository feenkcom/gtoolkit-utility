Class {
	#name : #GtRobocoderTemplateStringNode,
	#superclass : #GtRobocoderTemplatePartNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateStringNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitString: self
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> value [
	^ value
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
