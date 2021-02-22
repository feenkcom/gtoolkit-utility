Class {
	#name : #GtModelPropertyAnnouncementTemplate,
	#superclass : #Object,
	#instVars : [
		'__MODEL_NAME__Model'
	],
	#category : #'GToolkit-MVVM-Templates'
}

{ #category : #accessing }
GtModelPropertyAnnouncementTemplate >> __MODEL_NAME__Model [
	"Return a not-null __MODEL_NAME__ model assigned to the receiver announcement"
	self
		assert: [ __MODEL_NAME__Model notNil ]
		description: [ '__MODEL_NAME__ model should be initialized' ].

	^ __MODEL_NAME__Model
]

{ #category : #accessing }
GtModelPropertyAnnouncementTemplate >> __MODEL_NAME__Model: a__MODEL_NAME_CAPITALIZED__Model [
	"Set a not-null __MODEL_NAME__ domain model assigned to the receiver announcement"
	self
		assert: [ a__MODEL_NAME_CAPITALIZED__Model notNil ]
		description: [ '__MODEL_NAME__ model must not be nil' ].

	__MODEL_NAME__Model := a__MODEL_NAME_CAPITALIZED__Model
]
