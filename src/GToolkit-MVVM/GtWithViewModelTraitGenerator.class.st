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
