Class {
	#name : #GtPharoTemplateMethod,
	#superclass : #GtPharoTemplateArtefact,
	#instVars : [
		'sourceCode',
		'protocol'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #template }
GtPharoTemplateMethod class >> storageMethodTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{storageSelector}}
	<gtMethodTemplate>
	
	^ GtPharoTemplateMethod new
		sourceCode: {{sourceCode printString}};{{protocol
			ifNil: [ '''' ]
			ifNotNil: [ ''
		protocol: {{protocol printString}};'' ]}}
		storageMethod: thisContext method';
		protocol: 'template';
		storageMethod: thisContext method
]

{ #category : #initialize }
GtPharoTemplateMethod >> initialize [
	super initialize.
	
	sourceCode := 'method'.
	protocol := nil
]

{ #category : #accessing }
GtPharoTemplateMethod >> protocol [
	^ protocol
]

{ #category : #accessing }
GtPharoTemplateMethod >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
GtPharoTemplateMethod >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtPharoTemplateMethod >> sourceCode: anObject [
	sourceCode := anObject
]
