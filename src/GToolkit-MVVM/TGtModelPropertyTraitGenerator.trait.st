Trait {
	#name : #TGtModelPropertyTraitGenerator,
	#instVars : [
		'propertyName',
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
			#__PROPERTY_NAME_CAPITALIZED__-> self propertyName capitalized asSymbol.
			#__PROPERTY_TYPE__ -> self propertyType asString.
			#__PROPERTY_COMPARATOR__ -> self propertyComparator };
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
TGtModelPropertyTraitGenerator >> propertyType [
	^ propertyType
]

{ #category : #accessing }
TGtModelPropertyTraitGenerator >> propertyType: anObject [
	propertyType := anObject
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
