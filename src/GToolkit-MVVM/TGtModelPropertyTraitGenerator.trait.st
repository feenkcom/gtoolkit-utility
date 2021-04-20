Trait {
	#name : #TGtModelPropertyTraitGenerator,
	#instVars : [
		'environment',
		'propertyName',
		'propertySetter',
		'propertyUnsetter',
		'propertyType',
		'propertyComparator',
		'projectPrefix',
		'packageName',
		'tagName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> environment: anObject [
	environment := anObject
]

{ #category : #translating }
TGtModelPropertyTraitGenerator >> generate [
	<return: #Trait>

	^ self generator generate
]

{ #category : #translating }
TGtModelPropertyTraitGenerator >> generateBehaviorDefinition [
	<return: #GtTraitDefinition>

	^ self generator generateBehaviorDefinition
]

{ #category : #translating }
TGtModelPropertyTraitGenerator >> generator [
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

{ #category : #printing }
TGtModelPropertyTraitGenerator >> storeOn: aStream [
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
		tab; nextPutAll: 'tagName:'; space; print: (self tagName ifNil: [ '' ]); nextPut: $;; cr;
		tab; nextPutAll: 'generate'
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> tagName: anObject [
	tagName := anObject
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
