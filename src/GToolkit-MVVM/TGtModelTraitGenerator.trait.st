Trait {
	#name : #TGtModelTraitGenerator,
	#instVars : [
		'environment',
		'modelName',
		'projectPrefix',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
TGtModelTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
TGtModelTraitGenerator >> environment: anObject [
	environment := anObject
]

{ #category : #translating }
TGtModelTraitGenerator >> generate [
	<return: #Trait>

	^ self generator generate
]

{ #category : #translating }
TGtModelTraitGenerator >> generateBehaviorDefinition [
	<return: #GtTraitDefinition>

	^ self generator generateBehaviorDefinition
]

{ #category : #translating }
TGtModelTraitGenerator >> generator [
	<return: #Trait>

	^ GtTraitGenerator new
		environment: self environment;
		traitName: self traitName;
		packageName: self packageName;
		templateTrait: self templateTrait;
		templateMap: {
			#__MODEL_NAME__ -> self modelName.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (GtGeneratorUtilities camelCaseToSentence: self modelName).
			#__TRAIT_NAME__ -> self traitName asSymbol.
			#__GENERATOR_SOURCE_CODE__ -> self storeString }
]

{ #category : #accessing }
TGtModelTraitGenerator >> modelName [
	^ modelName
]

{ #category : #accessing }
TGtModelTraitGenerator >> modelName: anObject [
	modelName := anObject
]

{ #category : #accessing }
TGtModelTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
TGtModelTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
TGtModelTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
TGtModelTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #printing }
TGtModelTraitGenerator >> storeOn: aStream [
	aStream
		nextPutAll: self class name; space; nextPutAll: 'new'; cr;
		tab; nextPutAll: 'modelName'; space; print: self modelName; nextPut: $;; cr;
		tab; nextPutAll: 'projectPrefix:'; space; print: self projectPrefix; nextPut: $;; cr;
		tab; nextPutAll: 'packageName:'; space; print: self packageName; nextPut: $;; cr;
		tab; nextPutAll: 'generate'
]

{ #category : #accessing }
TGtModelTraitGenerator >> templateTrait [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelTraitGenerator >> traitName [
	<return: #Symbol>
	
	^ self explicitRequirement
]
