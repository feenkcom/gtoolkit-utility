Trait {
	#name : #TGtModelClassGenerator,
	#instVars : [
		'environment',
		'modelName',
		'projectPrefix',
		'packageName',
		'tagName',
		'traits'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
TGtModelClassGenerator >> className [
	<return: #Symbol>
	
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelClassGenerator >> environment [
	^ environment
]

{ #category : #accessing }
TGtModelClassGenerator >> environment: anObject [
	environment := anObject
]

{ #category : #translating }
TGtModelClassGenerator >> generate [
	<return: #Trait>

	^ self generator generate
]

{ #category : #translating }
TGtModelClassGenerator >> generateBehaviorDefinition [
	<return: #Trait>

	^ self generator generateBehaviorDefinition
]

{ #category : #translating }
TGtModelClassGenerator >> generator [
	<return: #GtClassGenerator>

	^ GtClassGenerator new
		environment: self environment;
		className: self className;
		packageName: self packageName;
		tagName: self tagName;
		templateClass: self templateClass;
		traits: self traits;
		templateMap: {
			#__MODEL_NAME__ -> self modelName.
			#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
			#__MODEL_NAME_TEXT__ -> (GtGeneratorUtilities camelCaseToSentence: self modelName) }
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
TGtModelClassGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
TGtModelClassGenerator >> tagName: anObject [
	tagName := anObject
]

{ #category : #accessing }
TGtModelClassGenerator >> templateClass [
	^ self explicitRequirement
]

{ #category : #accessing }
TGtModelClassGenerator >> traits [
	^ traits
]

{ #category : #accessing }
TGtModelClassGenerator >> traits: anObject [
	traits := anObject
]
