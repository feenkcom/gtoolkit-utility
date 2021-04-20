"
! View Trait generator

Usage example:
[[[
GtRobocoderWithObjectTraitGenerator new
	modelName: 'testViewModel';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate	
]]]
"
Class {
	#name : #GtRobocoderWithObjectTraitGenerator,
	#superclass : #Object,
	#traits : 'TGtModelTraitGenerator',
	#classTraits : 'TGtModelTraitGenerator classTrait',
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #translating }
GtRobocoderWithObjectTraitGenerator >> generator [
	<return: #Trait>

	^ GtRobocoderTraitGenerator new
		environment: self environment;
		traitName: self traitName;
		packageName: self packageName;
		tagName: self tagName;
		templateTrait: self templateTrait;
		templateMap: {
			#__MODEL_NAME__ -> self modelName uncapitalized.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (GtGeneratorUtilities camelCaseToSentence: self modelName) uncapitalized.
			#__TRAIT_NAME__ -> self traitName capitalized asSymbol.
			#__GENERATOR_SOURCE_CODE__ -> self storeString }
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> templateTrait [
	^ TGtRobocoderWithObjectTraitTemplate
]

{ #category : #private }
GtRobocoderWithObjectTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self modelName capitalized;
			nextPutAll: 'ViewModel' ]
]
