Trait {
	#name : #TGtNavigationViewModelChildrenAccessorTemplate,
	#instVars : [
		'__Child_view_model_class__'
	],
	#classInstVars : [
		'__Child_view_model_class__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #'private - instance creation' }
TGtNavigationViewModelChildrenAccessorTemplate >> create__View_models__ [
	^ self __model__ __children__ collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := __Child_view_model_class__ new.
		eachViewModel __child_parent_view_model__: self.
		eachViewModel __child_model_setter__ eachModel ]
]
