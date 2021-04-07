"
! View Trait generator

Usage example:
[[[
GtWithViewModelTraitGenerator new
	modelName: 'test';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate	
]]]
"
Class {
	#name : #GtWithViewModelTraitGenerator,
	#superclass : #Object,
	#traits : 'TGtModelTraitGenerator',
	#classTraits : 'TGtModelTraitGenerator classTrait',
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #translating }
GtWithViewModelTraitGenerator >> generate [
	<return: #Trait>

	^ GtTraitGenerator new
		traitName: self traitName;
		packageName: self packageName;
		templateTrait: self templateTrait;
		templateMap: {
			#__MODEL_NAME__ -> self modelName.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (GtGeneratorUtilities camelCaseToSentence: self modelName) };
		generate
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> templateTrait [
	^ TGtWithViewModelTraitTemplate
]

{ #category : #private }
GtWithViewModelTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self modelName capitalized;
			nextPutAll: 'ViewModel' ]
]
