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

{ #category : #translating }
GtWithPropertyTraitGenerator >> generate [
	<return: #Trait>

	^ GtTraitGenerator new
		traitName: self traitName;
		packageName: self packageName;
		templateTrait: self templateTrait;
		templateMap: {
			#__PROPERTY_NAME__ -> self propertyName asSymbol.
			#__PROPERTY_SETTER__ -> self propertySetter asSymbol.
			#__PROPERTY_UNSETTER__ -> self propertyUnsetter asSymbol.
			#__PROPERTY_NAME_CAPITALIZED__-> self propertyName capitalized asSymbol.
			#__PROPERTY_NAME_TEXT__-> (GtGeneratorUtilities camelCaseToSentence: self propertyName).
			#__PROPERTY_TYPE__ -> self propertyType asString.
			#__PROPERTY_COMPARATOR__ -> self propertyComparator.
			#__TRAIT_NAME__ -> self traitName asSymbol.
			#__GENERATOR_SOURCE_CODE__ -> self storeString };
		generate
]

{ #category : #printing }
GtWithPropertyTraitGenerator >> storeOn: aStream [
	aStream
		nextPutAll: self class name; space; nextPutAll: 'new'; cr;
		tab; nextPutAll: 'propertyName:'; space; print: self propertyName; nextPut: $;; cr.

	propertySetter ifNotNil: [ :aPropertySetter |
		aStream tab; nextPutAll: 'propertySetter:'; space; print: aPropertySetter; nextPut: $;; cr ].
	propertyUnsetter ifNotNil: [ :aPropertyUnsetter |
		aStream tab; nextPutAll: 'propertyUnsetter:'; space; print: aPropertyUnsetter; nextPut: $;; cr ].

	aStream
		tab; nextPutAll: 'propertyType:'; space; print: self propertyType; nextPut: $;; cr;
		tab; nextPutAll: 'propertyComparator:'; space; print: self propertyComparator; nextPut: $;; cr;
		tab; nextPutAll: 'projectPrefix:'; space; print: self projectPrefix; nextPut: $;; cr;
		tab; nextPutAll: 'packageName:'; space; print: self packageName; nextPut: $;; cr;
		tab; nextPutAll: 'generate'
]

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
