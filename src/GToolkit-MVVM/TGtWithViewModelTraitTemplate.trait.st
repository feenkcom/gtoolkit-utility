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
	<viewModelSetter>
	self
		assert: [ a__MODEL_NAME_CAPITALIZED__ViewModel notNil ]
		description: [ '__MODEL_NAME__ view model must not be nil' ].

	__MODEL_NAME__ViewModel == a__MODEL_NAME_CAPITALIZED__ViewModel 
		ifTrue: [ ^ self ].

	__MODEL_NAME__ViewModel ifNotNil: [ self unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel ].
	__MODEL_NAME__ViewModel := a__MODEL_NAME_CAPITALIZED__ViewModel.

	self on__MODEL_NAME_CAPITALIZED__ViewModelChanged.
	self subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel.
	self onPost__MODEL_NAME_CAPITALIZED__ViewModelChanged
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> hasViewModelTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''has'', modelName capitalized, ''ViewModel''}}
	"Return a true if {{modelName}} view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ {{modelName, ''ViewModel''}} notNil';
		storageMethod: thisContext method
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> has__MODEL_NAME_CAPITALIZED__ViewModel [
	"Return a true if __MODEL_NAME__ view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ __MODEL_NAME__ViewModel notNil
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> onPostViewModelChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''onPost'', modelName capitalized, ''ViewModelChanged''}}
	"I am an optional hook method that is sent after #{{''subscribeTo'', modelName capitalized, ''ViewModel''}}.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."';
		storageMethod: thisContext method
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> onPost__MODEL_NAME_CAPITALIZED__ViewModelChanged [
	"I am an optional hook method that is sent after #subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> onViewModelChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''on'', modelName capitalized, ''ViewModelChanged''}}
	"Is sent when a new {{modelName}} view model is assigned to the element.
	Note: #{{''on'', modelName capitalized, ''ViewModelChanged''}} is sent before #{{''subscribeTo'', modelName capitalized, ''ViewModel''}}
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn''t get a chance to subscribe to any announcement. Override #{{''onPost'', modelName capitalized, ''ViewModelChanged''}} if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement';
		storageMethod: thisContext method
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> on__MODEL_NAME_CAPITALIZED__ViewModelChanged [
	"Is sent when a new __MODEL_NAME__ view model is assigned to the element.
	Note: #on__MODEL_NAME_CAPITALIZED__ViewModelChanged is sent before #subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPost__MODEL_NAME_CAPITALIZED__ViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> subscribeToViewModelTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''subscribeTo'', modelName capitalized, ''ViewModel''}}
	"Is sent after a new {{modelName}} view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#{{''unsubscribeFrom'', modelName capitalized, ''ViewModel''}} if elements subscribe to them"';
		storageMethod: thisContext method
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> subscribeTo__MODEL_NAME_CAPITALIZED__ViewModel [
	"Is sent after a new __MODEL_NAME__ view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel if elements subscribe to them"
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> unsubscribeFromViewModelTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''unsubscribeFrom'', modelName capitalized, ''ViewModel''}}
	"Is sent before a new {{modelName}} view model is assigned to the element.
	Elements that subscribe to {{modelName}} view model in domain model are required to implement this methods."';
		storageMethod: thisContext method
]

{ #category : #'api - __MODEL_NAME_TEXT__ view model' }
TGtWithViewModelTraitTemplate >> unsubscribeFrom__MODEL_NAME_CAPITALIZED__ViewModel [
	"Is sent before a new __MODEL_NAME__ view model is assigned to the element.
	Elements that subscribe to __MODEL_NAME__ view model in domain model are required to implement this methods."
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> viewModelGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{modelName, ''ViewModel''}}
	"Return a not-null {{modelName}} view model assigned to the receiver element"
	self
		assert: [ {{modelName, ''ViewModel''}} notNil ]
		description: [ ''{{modelName}} view model should be initialized'' ].

	^ {{modelName, ''ViewModel''}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithViewModelTraitTemplate >> viewModelSetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{modelName, ''ViewModel''}}: {{''a'',modelName capitalized, ''ViewModel''}}
	"Set a not-null {{modelName}} view model assigned to the receiver element"
	<viewModelSetter>
	self
		assert: [ {{''a'',modelName capitalized, ''ViewModel''}} notNil ]
		description: [ ''{{modelName}} view model must not be nil'' ].

	{{modelName, ''ViewModel''}} == {{''a'',modelName capitalized, ''ViewModel''}}
		ifTrue: [ ^ self ].

	{{modelName, ''ViewModel''}} ifNotNil: [ self {{''unsubscribeFrom'', modelName capitalized, ''ViewModel''}} ].
	{{modelName, ''ViewModel''}} := {{''a'',modelName capitalized, ''ViewModel''}}.

	self {{''on'', modelName capitalized, ''ViewModelChanged''}}.
	self {{''subscribeTo'', modelName capitalized, ''ViewModel''}}.
	self {{''onPost'', modelName capitalized, ''ViewModelChanged''}}';
		storageMethod: thisContext method
]
