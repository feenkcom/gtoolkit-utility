"
! Model Trait generator

Usage example:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'test';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate	
]]]
"
Class {
	#name : #GtWithDomainModelTraitGenerator,
	#superclass : #Object,
	#traits : 'TGtMVVMTraitGenerator',
	#classTraits : 'TGtMVVMTraitGenerator classTrait',
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #accessing }
GtWithDomainModelTraitGenerator >> templateTrait [
	^ TGtWithDomainModelTraitTemplate
]

{ #category : #accessing }
GtWithDomainModelTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self modelName capitalized;
			nextPutAll: 'Model' ]
]
