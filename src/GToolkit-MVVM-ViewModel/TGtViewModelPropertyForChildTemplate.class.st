"
!! Additional ==__property_name__== api for a child view model
${class:__View_model_class__}$ is a child of the ${class:__Parent_view_model_class__}$ which supports ==__property_name__== property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - ${method:__View_model_class__>>#is__Status____Object__}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:__Parent_view_model_class__>>#__parent_property_getter__}$).
 - ${method:__View_model_class__>>#isOnly__Status____Object__}$ allows users to check if a particular child view model is the property value of the the parent view model (${method:__Parent_view_model_class__>>#__parent_property_getter__}$) and that thre are no child view models of ${class:__View_model_class__}$ that have the sasme property ==__property_name__== set.
 - ${method:__View_model_class__>>#__unset__OtherEntities}$ ensures that none of the ${class:__View_model_class__}$ child view models have ==__property_name__== property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned ==__property_name__== property.
 - ${method:__View_model_class__>>#notify__Object____Status__}$ sends an announcement (${class:__Status_announcement__}$) indicating that the child view model is now the property value in the parent view model (${method:__Parent_view_model_class__>>#__parent_property_getter__}$). At this point ${method:__View_model_class__>>#is__Status____Object__}$ returns ==true==.
 - ${method:__View_model_class__>>#notify__Object____Status_not__}$ sends an announcement (${class:__Status_not_announcement__}$) indicating that the child view model is no more the property value in the parent view model (${method:__Parent_view_model_class__>>#__parent_property_getter__}$). At this point ${method:__View_model_class__>>#is__Status____Object__}$ returns ==false==.
"
Class {
	#name : #TGtViewModelPropertyForChildTemplate,
	#superclass : #Object,
	#classVars : [
		'__Status_announcement__',
		'__Status_not_announcement__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Templates'
}

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> __set____Object__ [
	"Just __set__ a __object__ without changing children"
	<propertySetter: #__property_name__>

	self __parent_object_getter__ __parent_property_setter__ self
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> __set____Object__WithoutOtherEntities [
	"__Set__ a __object__ and __unset__ other __status__ children"

	self __unset__OtherEntities.
	self __set____Object__
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> __unset__OtherEntities [
	"__Unset__ any __status__ child"
	<propertyUnsetOthers: #__property_name__>
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> hasOther__Status__Entities [
	"Return true if there are other __status__ entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #__property_name__>

	^ false
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> isOnly__Status____Object__ [
	"Return true if only this __object__ is __status__ and not any of the children"
	<return: #Boolean>

	^ self is__Status____Object__ and: [ self hasOther__Status__Entities not ]
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> is__Status____Object__ [
	"Return true if this __object__ is __status__"
	<return: #Boolean>

	^ self __parent_object_getter__ __has_parent_property__
		and: [ self __parent_object_getter__ __parent_property_getter__ == self ]
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> notify__Object____Status__ [
	<propertySetNotifier: #__property_name__>

	self announce: (__Status_announcement__ new __object__ViewModel: self)
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> notify__Object____Status_not__ [
	<propertyUnsetNotifier: #__property_name__>

	self announce: (__Status_not_announcement__ new __object__ViewModel: self)
]
