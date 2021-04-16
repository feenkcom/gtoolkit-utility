"
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:__View_model_class__>>#__view_model__}$ returns a parent view model (${class:__Parent_view_model_class__}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:__View_model_class__>>#__view_model__:}$ allows users to assign a non-null parent view model (${class:__Parent_view_model_class__}$).
 - ${method:__View_model_class__>>#has__View_model__}$ can be used to test if a parent view model (${class:__Parent_view_model_class__}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:__View_model_class__>>#has__View_model__}$ before trying to access ${method:__View_model_class__>>#__view_model__}$
"
Trait {
	#name : #TGtViewModelParentAccessorTemplate,
	#instVars : [
		'__view_model__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Templates'
}

{ #category : #'api - accessing' }
TGtViewModelParentAccessorTemplate >> __view_model__ [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #__Parent_view_model_class__>
	<parentViewModelGetter: #__parent_name__>

	self
		assert: [ __view_model__ notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ __view_model__
]

{ #category : #'api - accessing' }
TGtViewModelParentAccessorTemplate >> __view_model__: a__Parent_view_model_class__ [
	"Assign a parent view model (${class:__Parent_view_model_class__}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #__parent_name__>

	self
		assert: [ a__Parent_view_model_class__ notNil ]
		description: [ 'Parent view model must not be nil' ].

	__view_model__ := a__Parent_view_model_class__
]

{ #category : #'api - accessing' }
TGtViewModelParentAccessorTemplate >> has__View_model__ [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #__parent_name__>

	^ __view_model__ notNil
]
