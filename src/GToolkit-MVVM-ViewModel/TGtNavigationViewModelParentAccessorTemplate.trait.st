Trait {
	#name : #TGtNavigationViewModelParentAccessorTemplate,
	#instVars : [
		'__view_model__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #'api - accessing' }
TGtNavigationViewModelParentAccessorTemplate >> __view_model__ [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #__View_model_class__>

	self
		assert: [ __view_model__ notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ __view_model__
]

{ #category : #'api - accessing' }
TGtNavigationViewModelParentAccessorTemplate >> __view_model__: a__View_model_class__ [
	"Assign a parent view model (${class:__View_model_class__}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	self
		assert: [ a__View_model_class__ notNil ]
		description: [ 'Parent view model must not be nil' ].

	__view_model__ := a__View_model_class__
]