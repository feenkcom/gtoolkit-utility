Trait {
	#name : #TGtModelTraitGenerator,
	#instVars : [
		'modelName',
		'projectPrefix',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #translating }
TGtModelTraitGenerator >> generate [
	<return: #Trait>

	^ GtWithTraitGenerator new
		traitName: self traitName;
		packageName: self packageName;
		templateTrait: self templateTrait;
		templateMap: {
			#__MODEL_NAME__ -> self modelName.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (String streamContents: [ :aStream | 
				self modelName gtPiecesCutWhereCamelCase 
					do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
					separatedBy: [ aStream nextPut: Character space ] ]) };
		generate
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

{ #category : #accessing }
TGtModelTraitGenerator >> templateTrait [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelTraitGenerator >> traitName [
	<return: #Symbol>
	
	^ self explicitRequirement
]