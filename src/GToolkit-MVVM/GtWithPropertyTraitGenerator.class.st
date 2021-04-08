"
! Property Trait generator

Usage example:
[[[
GtWithPropertyTraitGenerator new
	propertyName: 'size';
	propertyType: 'Point';
	propertyComparator: #closeTo:;
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate.
]]]
"
Class {
	#name : #GtWithPropertyTraitGenerator,
	#superclass : #Object,
	#traits : 'TGtModelPropertyTraitGenerator',
	#classTraits : 'TGtModelPropertyTraitGenerator classTrait',
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #accessing }
GtWithPropertyTraitGenerator >> templateTrait [
	^ TGtWithModelPropertyTraitTemplate
]

{ #category : #accessing }
GtWithPropertyTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self propertyName capitalized ]
]
