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
	<propertySetter: #__Property_name__>

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
	<propertyUnsetOthers: #__Property_name__>
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> hasOther__Status__Entities [
	"Return true if there are other __status__ entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #__Property_name__>

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
	<propertySetNotifier: #__Property_name__>

	self announce: __Status_announcement__ new
]

{ #category : #'api - __property__' }
TGtViewModelPropertyForChildTemplate >> notify__Object____Status_not__ [
	<propertyUnsetNotifier: #__Property_name__>

	self announce: __Status_not_announcement__ new
]
