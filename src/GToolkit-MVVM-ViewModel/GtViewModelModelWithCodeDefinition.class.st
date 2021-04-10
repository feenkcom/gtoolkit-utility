Class {
	#name : #GtViewModelModelWithCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'viewModelModel',
		'definition',
		'extraDefinitions',
		'allViewModelModelDefinitions'
	],
	#category : #'GToolkit-MVVM-ViewModel-Model'
}

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> addExtraDefinition: aGtCodeDefinition [
	extraDefinitions add: aGtCodeDefinition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> addExtraDefinitions: aCollectionOfGtCodeDefinition [
	extraDefinitions addAll: aCollectionOfGtCodeDefinition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> allViewModelModelDefinitions [
	^ allViewModelModelDefinitions
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> allViewModelModelDefinitions: anObject [
	allViewModelModelDefinitions := anObject
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> children [
	<return: #Collection of: #GtViewModelModelWithCodeDefinition>

	^ self viewModelModel children collect: [ :eachChildViewModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachChildViewModel ]
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> definition [
	^ definition
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> extraDefinitions [
	^ extraDefinitions
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> extraDefinitions: anObject [
	extraDefinitions := anObject asOrderedCollection
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> forOneModel [
	<return: #GtViewModelModelWithCodeDefinition>

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel forOneModel
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> hasParent [
	^ self viewModelModel hasParent
]

{ #category : #initialization }
GtViewModelModelWithCodeDefinition >> initialize [
	super initialize.
	
	extraDefinitions := OrderedCollection new
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> isForMany [
	^ self viewModelModel isForMany
]

{ #category : #testing }
GtViewModelModelWithCodeDefinition >> isForOne [
	^ self viewModelModel isForOne
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> name [
	^ self viewModelModel name
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> parent [
	<return: #GtViewModelModelWithCodeDefinition>

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self viewModelModel parent
]

{ #category : #'api - accessing' }
GtViewModelModelWithCodeDefinition >> parentViewModelSelectorName [
	^ self viewModelModel parentViewModelSelectorName
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> viewModelModel [
	<return: #GtViewModelModel>

	^ viewModelModel
]

{ #category : #accessing }
GtViewModelModelWithCodeDefinition >> viewModelModel: anObject [
	viewModelModel := anObject
]
