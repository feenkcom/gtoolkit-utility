Trait {
	#name : #TGtModelClassGenerator,
	#instVars : [
		'modelName',
		'projectPrefix',
		'packageName',
		'properties'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
TGtModelClassGenerator >> className [
	<return: #Symbol>
	
	^ self explicitRequirement
]

{ #category : #translating }
TGtModelClassGenerator >> generate [
	<return: #Trait>

	^ GtClassGenerator new
		className: self className;
		packageName: self packageName;
		templateClass: self templateClass;
		traits: self traits;
		templateMap: {
			#__MODEL_NAME__ -> self modelName.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (GtGeneratorUtilities camelCaseToSentence: self modelName) };
		generate
]

{ #category : #accessing }
TGtModelClassGenerator >> modelName [
	^ modelName
]

{ #category : #accessing }
TGtModelClassGenerator >> modelName: anObject [
	modelName := anObject
]

{ #category : #accessing }
TGtModelClassGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
TGtModelClassGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
TGtModelClassGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
TGtModelClassGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #accessing }
TGtModelClassGenerator >> properties [
	^ properties
]

{ #category : #accessing }
TGtModelClassGenerator >> properties: anObject [
	properties := anObject
]

{ #category : #accessing }
TGtModelClassGenerator >> templateClass [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelClassGenerator >> traits [
	^ self explicitRequirement
]
