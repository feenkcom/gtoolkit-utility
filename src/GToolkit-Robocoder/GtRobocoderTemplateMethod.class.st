Class {
	#name : #GtRobocoderTemplateMethod,
	#superclass : #GtRobocoderTemplateArtefact,
	#instVars : [
		'sourceCode',
		'protocol'
	],
	#category : #'GToolkit-Robocoder-Model'
}

{ #category : #template }
GtRobocoderTemplateMethod class >> storageMethodTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{storageSelector}}
	<gtMethodTemplate>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: {{sourceCode printString}};{{protocol
			ifNil: [ '''' ]
			ifNotNil: [ ''
		protocol: {{protocol printString}};'' ]}}
		storageMethod: thisContext method';
		protocol: 'template';
		storageMethod: thisContext method
]

{ #category : #initialize }
GtRobocoderTemplateMethod >> initialize [
	super initialize.
	
	sourceCode := 'method'.
	protocol := nil
]

{ #category : #accessing }
GtRobocoderTemplateMethod >> protocol [
	^ protocol
]

{ #category : #accessing }
GtRobocoderTemplateMethod >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
GtRobocoderTemplateMethod >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtRobocoderTemplateMethod >> sourceCode: anObject [
	sourceCode := anObject
]
