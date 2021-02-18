Trait {
	#name : #TGtMVVMTraitGenerator,
	#instVars : [
		'modelName',
		'projectPrefix',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #translating }
TGtMVVMTraitGenerator >> generate [
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
TGtMVVMTraitGenerator >> modelName [
	^ modelName
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> modelName: anObject [
	modelName := anObject
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> templateTrait [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtMVVMTraitGenerator >> traitName [
	<return: #Symbol>
	
	^ self explicitRequirement
]
