Class {
	#name : #TGtViewModelChildrenForManyAccessorTemplate,
	#superclass : #Object,
	#instVars : [
		'__child_view_models__'
	],
	#classVars : [
		'__Child_view_model_class__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Templates'
}

{ #category : #'api - accessing' }
TGtViewModelChildrenForManyAccessorTemplate >> __child_view_models__ [
	"Return a collection of view models (${class:__Child_view_model_class__}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #__Child_view_model_class__>

	^  __child_view_models__ ifNil: [ __child_view_models__ := self create__Child_view_models__ ]
]

{ #category : #'private - instance creation' }
TGtViewModelChildrenForManyAccessorTemplate >> create__Child_view_models__ [
	"For each child from the domain modal create a view model and return a resulting collection"
	<return: #Collection of: #__Child_view_model_class__>
	
	^ self __model__ __children__ collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := __Child_view_model_class__ new.
		eachViewModel __child_parent_view_model_setter__ self.
		eachViewModel __child_model_setter__ eachModel ]
]
