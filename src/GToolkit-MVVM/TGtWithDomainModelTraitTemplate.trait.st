"
!! Generation
${class:__TRAIT_NAME__}$ was automatically generated with the following code:
[[[
__GENERATOR_SOURCE_CODE__
]]] 

"
Trait {
	#name : #TGtWithDomainModelTraitTemplate,
	#instVars : [
		'__MODEL_NAME__Model'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> __MODEL_NAME__Model [
	"Return a not-null __MODEL_NAME__ model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ __MODEL_NAME__Model notNil ]
		description: [ '__MODEL_NAME__ model should be initialized' ].

	^ __MODEL_NAME__Model
]

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> __MODEL_NAME__Model: a__MODEL_NAME_CAPITALIZED__Model [
	"Set a not-null __MODEL_NAME__ domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ a__MODEL_NAME_CAPITALIZED__Model notNil ]
		description: [ '__MODEL_NAME__ model must not be nil' ].

	__MODEL_NAME__Model == a__MODEL_NAME_CAPITALIZED__Model 
		ifTrue: [ ^ self ].

	__MODEL_NAME__Model ifNotNil: [ self unsubscribeFrom__MODEL_NAME_CAPITALIZED__Model ].
	__MODEL_NAME__Model := a__MODEL_NAME_CAPITALIZED__Model.

	self on__MODEL_NAME_CAPITALIZED__ModelChanged.
	self subscribeTo__MODEL_NAME_CAPITALIZED__Model
]

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> has__MODEL_NAME_CAPITALIZED__ [
	"Return a true if __MODEL_NAME__ model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ __MODEL_NAME__Model notNil
]

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> on__MODEL_NAME_CAPITALIZED__ModelChanged [
	"Is sent when a new __MODEL_NAME__ model is assigned to the view model"
]

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> subscribeTo__MODEL_NAME_CAPITALIZED__Model [
	"Is sent after a new __MODEL_NAME__ model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFrom__MODEL_NAME_CAPITALIZED__Model if view model subscribes to them"
]

{ #category : #'api - __MODEL_NAME_TEXT__ model' }
TGtWithDomainModelTraitTemplate >> unsubscribeFrom__MODEL_NAME_CAPITALIZED__Model [
	"Is sent before a new __MODEL_NAME__ model is assigned to the view model.
	View models that subscribe to __MODEL_NAME__ model are required to implement this methods"
]
