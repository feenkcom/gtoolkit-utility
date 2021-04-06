"
! With __PROPERTY_NAME_TEXT__ 
Is used to add support for ==__PROPERTY_NAME__== to a user class.
!! Implemented api:
The trait implements the following methods:
 - ${method:__TRAIT_NAME__>>#__PROPERTY_NAME__}$ to get the value of the __PROPERTY_NAME_TEXT__
 - ${method:__TRAIT_NAME__>>#__PROPERTY_SETTER__:}$ to set a new value of the __PROPERTY_NAME_TEXT__
 - ${method:__TRAIT_NAME__>>#__PROPERTY_UNSETTER__}$ to unset the value of the __PROPERTY_NAME_TEXT__ (set it to nil)
 - ${method:__TRAIT_NAME__>>#has__PROPERTY_NAME_CAPITALIZED__}$ to check if the __PROPERTY_NAME_TEXT__ has an assigned value (the default value is nil)
 - ${method:__TRAIT_NAME__>>#notify__PROPERTY_NAME_CAPITALIZED__Changed}$ to announce changes to the value of the __PROPERTY_NAME_TEXT__. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - ${method:__TRAIT_NAME__>>#onPrevious__PROPERTY_NAME_CAPITALIZED__Unset:}$ (advanced) - is a hook sent after a previous non-nil value of the __PROPERTY_NAME_TEXT__ is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - ${method:__TRAIT_NAME__>>#onNew__PROPERTY_NAME_CAPITALIZED__Set:}$ (advanced) - is a hook sent after a new value of the __PROPERTY_NAME_TEXT__ is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
!! Generation
${class:__TRAIT_NAME__}$ was automatically generated with the following code:
[[[
__GENERATOR_SOURCE_CODE__
]]] 

"
Trait {
	#name : #TGtWithModelPropertyTraitTemplate,
	#instVars : [
		'__PROPERTY_NAME__'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> __PROPERTY_NAME__ [
	<return: #__PROPERTY_TYPE__>

	^ __PROPERTY_NAME__
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> __PROPERTY_SETTER__: aNew__PROPERTY_NAME_CAPITALIZED__ [
	(self __PROPERTY_NAME__ __PROPERTY_COMPARATOR__ aNew__PROPERTY_NAME_CAPITALIZED__)
		ifTrue: [ ^ self ].
	
	self has__PROPERTY_NAME_CAPITALIZED__
		ifTrue: [
			| aPrevious__PROPERTY_NAME_CAPITALIZED__ |
			aPrevious__PROPERTY_NAME_CAPITALIZED__ := __PROPERTY_NAME__.
			__PROPERTY_NAME__ := nil.
			self onPrevious__PROPERTY_NAME_CAPITALIZED__Unset: aPrevious__PROPERTY_NAME_CAPITALIZED__ ].
	__PROPERTY_NAME__ := aNew__PROPERTY_NAME_CAPITALIZED__.
	self onNew__PROPERTY_NAME_CAPITALIZED__Set: aNew__PROPERTY_NAME_CAPITALIZED__.
	self notify__PROPERTY_NAME_CAPITALIZED__Changed
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> __PROPERTY_UNSETTER__ [
	| aPrevious__PROPERTY_NAME_CAPITALIZED__ |

	__PROPERTY_NAME__
		ifNil: [ ^ self ].

	aPrevious__PROPERTY_NAME_CAPITALIZED__ := __PROPERTY_NAME__.
	__PROPERTY_NAME__ := nil.
	self onPrevious__PROPERTY_NAME_CAPITALIZED__Unset: aPrevious__PROPERTY_NAME_CAPITALIZED__.
	self notify__PROPERTY_NAME_CAPITALIZED__Changed
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> has__PROPERTY_NAME_CAPITALIZED__ [
	<return: #Boolean>

	^ __PROPERTY_NAME__ notNil
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> notify__PROPERTY_NAME_CAPITALIZED__Changed [
	"Override this notify method to announce changes to the property"
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> onNew__PROPERTY_NAME_CAPITALIZED__Set: aNew__PROPERTY_NAME_CAPITALIZED__ [
	"Is sent after a new value of the __PROPERTY_NAME__ is assigned"
]

{ #category : #'api - __PROPERTY_NAME_TEXT__' }
TGtWithModelPropertyTraitTemplate >> onPrevious__PROPERTY_NAME_CAPITALIZED__Unset: aPrevious__PROPERTY_NAME_CAPITALIZED__ [
	"Is sent after a previous value of the __PROPERTY_NAME__ is de-assigned"
]
