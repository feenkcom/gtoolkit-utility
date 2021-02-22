"
! Model Property Trait generator

Usage example:
[[[
GtWithModelPropertyTraitGenerator new
	propertyName: 'size';
	propertyType: 'Point';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate.
]]]
"
Class {
	#name : #GtWithModelPropertyTraitGenerator,
	#superclass : #Object,
	#traits : 'TGtModelPropertyTraitGenerator',
	#classTraits : 'TGtModelPropertyTraitGenerator classTrait',
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #accessing }
GtWithModelPropertyTraitGenerator >> templateTrait [
	^ TGtWithModelPropertyTraitTemplate
]

{ #category : #accessing }
GtWithModelPropertyTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self propertyName capitalized ]
]
