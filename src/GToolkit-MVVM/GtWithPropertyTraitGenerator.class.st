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
GtWithPropertyTraitGenerator >> generator [
	<return: #Trait>

	^ GtRobocoderTraitGenerator new
		environment: self environment;
		traitName: self traitName;
		packageName: self packageName;
		tagName: self tagName;
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
			#__GENERATOR_SOURCE_CODE__ -> self storeString }
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
