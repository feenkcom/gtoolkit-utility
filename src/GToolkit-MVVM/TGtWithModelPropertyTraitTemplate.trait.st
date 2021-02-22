Trait {
	#name : #TGtWithModelPropertyTraitTemplate,
	#instVars : [
		'__PROPERTY_NAME__'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #'api - __PROPERTY_NAME__' }
TGtWithModelPropertyTraitTemplate >> __PROPERTY_NAME__ [
	<return: #__PROPERTY_TYPE__>

	^ __PROPERTY_NAME__
]

{ #category : #'api - __PROPERTY_NAME__' }
TGtWithModelPropertyTraitTemplate >> __PROPERTY_NAME__: aNew__PROPERTY_NAME_CAPITALIZED__ [
	self __PROPERTY_NAME__ = aNew__PROPERTY_NAME_CAPITALIZED__
		ifTrue: [ ^ self ].

	__PROPERTY_NAME__ := aNew__PROPERTY_NAME_CAPITALIZED__.
	self notify__PROPERTY_NAME_CAPITALIZED__Changed.
]

{ #category : #'api - __PROPERTY_NAME__' }
TGtWithModelPropertyTraitTemplate >> notify__PROPERTY_NAME_CAPITALIZED__Changed [
	self explicitRequirement
]
