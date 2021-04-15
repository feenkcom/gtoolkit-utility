Class {
	#name : #GtViewModelDerive,
	#superclass : #Object,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelDerive class >> deriveNamed: aDeriveName ifFound: aBlock [
	(self allSubclasses
		select: [ :eachClass | eachClass isAbstract not ])
			detect: [ :eachClass | eachClass label = aDeriveName ]
			ifFound: aBlock
]

{ #category : #accessing }
GtViewModelDerive class >> label [
	^ self subclassResponsibility
]

{ #category : #comparing }
GtViewModelDerive >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'api - generation' }
GtViewModelDerive >> applyOnViewModelModelWithCodeDefinition: aGtViewModelModelWithCodeDefinition [
	self applyOnViewModelModelsWithCodeDefinitions: (GtViewModelModelsWithCodeDefinitions new definitions: { aGtViewModelModelWithCodeDefinition })
]

{ #category : #'api - generation' }
GtViewModelDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	self subclassResponsibility
]

{ #category : #comparing }
GtViewModelDerive >> hash [
	^ self class hash
]
