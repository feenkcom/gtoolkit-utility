Trait {
	#name : #TGtWithViewModelTraitTemplate,
	#instVars : [
		'__MODEL_NAME__ViewModel'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> __MODEL_NAME__ViewModel [
	"Return a not-null __MODEL_NAME__ view model assigned to the receiver element"
	self
		assert: [ __MODEL_NAME__ViewModel notNil ]
		description: [ '__MODEL_NAME__ view model should be initialized' ].

	^ __MODEL_NAME__ViewModel
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> __MODEL_NAME__ViewModel: a__MODEL_NAME_CAPITALIZED__ViewModel [
	"Set a not-null __MODEL_NAME__ view model assigned to the receiver element"
	self
		assert: [ a__MODEL_NAME_CAPITALIZED__ViewModel notNil ]
		description: [ '__MODEL_NAME__ view model must not be nil' ].

	__MODEL_NAME__ViewModel == a__MODEL_NAME_CAPITALIZED__ViewModel 
		ifTrue: [ ^ self ].

	__MODEL_NAME__ViewModel ifNotNil: [ self unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel ].
	__MODEL_NAME__ViewModel := a__MODEL_NAME_CAPITALIZED__ViewModel.

	self on__MODEL_NAME_CAPITALIZED__ViewModelChanged.
	self subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> has__MODEL_NAME_CAPITALIZED__ [
	"Return a true if __MODEL_NAME__ view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ __MODEL_NAME__ViewModel notNil
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> on__MODEL_NAME_CAPITALIZED__ViewModelChanged [
	"Is sent when a new __MODEL_NAME__ view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel [
	"Is sent after a new __MODEL_NAME__ view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel if elements subscribe to them"
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel [
	"Is sent before a new __MODEL_NAME__ view model is assigned to the element.
	Elements that subscribe to __MODEL_NAME__ view model in domain model are required to implement this methods"
]
