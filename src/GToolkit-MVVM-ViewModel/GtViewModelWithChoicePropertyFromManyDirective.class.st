Class {
	#name : #GtViewModelWithChoicePropertyFromManyDirective,
	#superclass : #GtViewModelWithPropertyDirective,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #testing }
GtViewModelWithChoicePropertyFromManyDirective class >> isAbstract [
	^ self = GtViewModelWithChoicePropertyFromManyDirective
]

{ #category : #'private - methods' }
GtViewModelWithChoicePropertyFromManyDirective >> propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertySetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtViewModelWithChoicePropertyFromManyDirective >> propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithChoicePropertyFromManyDirective >> propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtViewModelWithChoicePropertyFromManyDirective >> propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithChoicePropertyFromManyDirective >> propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtViewModelWithChoicePropertyFromManyDirective >> propertyUnsetOthersSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition) selector
]
