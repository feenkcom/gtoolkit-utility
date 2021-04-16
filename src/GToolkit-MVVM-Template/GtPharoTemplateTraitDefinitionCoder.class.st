Class {
	#name : #GtPharoTemplateTraitDefinitionCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'templateMethod',
		'bindings',
		'templateTrait'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #initialization }
GtPharoTemplateTraitDefinitionCoder >> forMethod: aCompiledMethod [
	| aTemplateTrait |
	aTemplateTrait := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ].

	self forTemplateTrait: aTemplateTrait
]

{ #category : #initialization }
GtPharoTemplateTraitDefinitionCoder >> forTemplateTrait: aGtPharoTemplateTrait [
	templateTrait := aGtPharoTemplateTrait
]
