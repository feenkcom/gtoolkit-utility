Trait {
	#name : #TGtModelPropertyTraitGenerator,
	#instVars : [
		'propertyName',
		'propertySetter',
		'propertyUnsetter',
		'propertyType',
		'propertyComparator',
		'projectPrefix',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #translating }
TGtModelPropertyTraitGenerator >> generate [
	<return: #Trait>

	^ GtWithTraitGenerator new
		traitName: self traitName;
		packageName: self packageName;
		templateTrait: self templateTrait;
		templateMap: {
			#__PROPERTY_NAME__ -> self propertyName asSymbol.
			#__PROPERTY_SETTER__ -> self propertySetter asSymbol.
			#__PROPERTY_UNSETTER__ -> self propertyUnsetter asSymbol.
			#__PROPERTY_NAME_CAPITALIZED__-> self propertyName capitalized asSymbol.
			#__PROPERTY_NAME_TEXT__-> (GtWithTraitGenerator camelCaseToSentence: self propertyName).
			#__PROPERTY_TYPE__ -> self propertyType asString.
			#__PROPERTY_COMPARATOR__ -> self propertyComparator.
			#__TRAIT_NAME__ -> self traitName asSymbol.
			#__GENERATOR_SOURCE_CODE__ -> self storeString };
		generate
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyComparator [
	^ propertyComparator ifNil: [ #= ]
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyComparator: anObject [
	propertyComparator := anObject
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyName [
	^ propertyName
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyName: anObject [
	propertyName := anObject
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertySetter [
	^ propertySetter ifNil: [ propertyName ]
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertySetter: aSymbol [
	propertySetter := aSymbol
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyType [
	^ propertyType
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyType: anObject [
	propertyType := anObject
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyUnsetter [
	^ propertyUnsetter ifNil: [ 'unset', propertyName capitalized ]
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyUnsetter: aString [
	propertyUnsetter := aString
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> templateTrait [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> traitName [
	<return: #Symbol>
	
	^ self explicitRequirement
]
