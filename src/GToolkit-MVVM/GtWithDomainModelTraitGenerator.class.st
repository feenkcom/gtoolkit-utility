"
! Model Trait generator
"
Class {
	#name : #GtWithDomainModelTraitGenerator,
	#superclass : #GtWithViewModelTraitGenerator,
	#category : #'GToolkit-MVVM'
}

{ #category : #'private - template' }
GtWithDomainModelTraitGenerator >> __SUBSCRIBE_TO_VIEW_MODEL_HOOK__ [
	"Is sent after a new __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the element.
	It is required to unsubscribe from the domain model by implementing
	#__UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ if view models subscribe to them"
]

{ #category : #'private - template' }
GtWithDomainModelTraitGenerator >> __UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ [
	"Is sent before a new __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the element.
	View models that subscribe to the domain model are required to implement this methods"
]

{ #category : #private }
GtWithDomainModelTraitGenerator >> methodProtocolPattern [
	^ 'api - {1} model'
]

{ #category : #private }
GtWithDomainModelTraitGenerator >> modelNameSuffix [
	^ 'Model'
]
