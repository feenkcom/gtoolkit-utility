Class {
	#name : #TGtViewModelChildrenForOneAccessorTemplate,
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
TGtViewModelChildrenForOneAccessorTemplate >> __child_view_models__ [
	"Return a composite view model (${class:__Child_view_model_class__}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #__Child_view_model_class__>

	^  __child_view_models__ ifNil: [ __child_view_models__ := self create__Child_view_models__ ]
]

{ #category : #'private - instance creation' }
TGtViewModelChildrenForOneAccessorTemplate >> create__Child_view_models__ [
	"Create a composite view model for a collection of children and return the result"
	<return: #__Child_view_model_class__>
	| childrenViewModel |

	childrenViewModel := __Child_view_model_class__ new.
	childrenViewModel __child_parent_view_model_setter__ self.
	childrenViewModel __child_model_setter__ self __model__ __children__.
	^ childrenViewModel
]
