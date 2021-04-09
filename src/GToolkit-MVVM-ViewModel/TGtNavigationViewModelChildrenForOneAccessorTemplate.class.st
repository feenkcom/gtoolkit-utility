Class {
	#name : #TGtNavigationViewModelChildrenForOneAccessorTemplate,
	#superclass : #Object,
	#instVars : [
		'__child_view_models__'
	],
	#classVars : [
		'__Child_view_model_class__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #'api - accessing' }
TGtNavigationViewModelChildrenForOneAccessorTemplate >> __child_view_models__ [
	"Return a collection of view models (${class:__Child_view_model_class__}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #__Child_view_model_class__>

	^  __child_view_models__ ifNil: [ __child_view_models__ := self create__Child_view_models__ ]
]

{ #category : #'private - instance creation' }
TGtNavigationViewModelChildrenForOneAccessorTemplate >> create__Child_view_models__ [
	"Create a composite view model for a collection of children and return the result"
	<return: #__Child_view_model_class__>
	| childrenViewModel |

	childrenViewModel := __Child_view_model_class__ new.
	childrenViewModel __child_parent_view_model_setter__ self.
	childrenViewModel __child_model_setter__ self __model__ __children__.
	^ childrenViewModel
]
