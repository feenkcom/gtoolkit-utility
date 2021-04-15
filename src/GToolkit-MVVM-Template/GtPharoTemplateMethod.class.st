Class {
	#name : #GtPharoTemplateMethod,
	#superclass : #Object,
	#instVars : [
		'sourceCode',
		'protocol',
		'storageBehavior',
		'storageSelector'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #template }
GtPharoTemplateMethod class >> storageMethodTemplate [
	<gtMethodTemplate>
	
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
	protocol := nil.
	storageSelector := nil.
	storageBehavior := GtPharoCoderBehavior unspecified
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

{ #category : #accessing }
GtPharoTemplateMethod >> storageBehavior [
	^ storageBehavior
]

{ #category : #initialize }
GtPharoTemplateMethod >> storageBehavior: aBehavior selector: aSelector [
	storageBehavior := GtPharoCoderBehavior explicit: aBehavior.
	storageSelector := aSelector
]

{ #category : #initialize }
GtPharoTemplateMethod >> storageMethod: aCompiledMethod [
	storageSelector := aCompiledMethod selector.
	storageBehavior := GtPharoCoderBehavior explicit: aCompiledMethod methodClass
]

{ #category : #accessing }
GtPharoTemplateMethod >> storageSelector [
	^ storageSelector
]
