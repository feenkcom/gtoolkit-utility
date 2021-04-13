Class {
	#name : #GtViewModelNotifyDerive,
	#superclass : #GtViewModelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelNotifyDerive class >> label [
	^ 'notify'
]

{ #category : #'api - generation' }
GtViewModelNotifyDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |
		self generateViewModelAnnounceMethodFor: eachViewModelModelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtViewModelNotifyDerive >> generateViewModelAnnounceMethodFor: aViewModelModelWithCodeDefinition [
	| anAnnounceMethod aMethodSourceCode |

	aViewModelModelWithCodeDefinition hasParents
		ifFalse: [ ^ self ].

	anAnnounceMethod := nil.
	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods do: [ :eachMethod |
		eachMethod selector = #announce:
			ifTrue: [ anAnnounceMethod := eachMethod ] ].
	
	anAnnounceMethod
		ifNil: [ ^ self ].
	
	aMethodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: anAnnounceMethod sourceCode; nextPut: $.; cr; cr;
			tab; nextPutAll: '"Dispatch an event to the parent view model if it is assigned"'.
			
		aViewModelModelWithCodeDefinition parents do: [ :eachParentViewModelModelWithDefinition |
			aStream nextPutAll: ('
	self {parentTester}
		ifTrue: [ self {parentGetter} announce: {announcement} ].'
			format: { 
				#parentTester -> (aViewModelModelWithCodeDefinition parentViewModelTesterMethodFor: eachParentViewModelModelWithDefinition) selector.
				#parentGetter -> (aViewModelModelWithCodeDefinition parentViewModelGetterMethodFor: eachParentViewModelModelWithDefinition) selector.
				#announcement -> anAnnounceMethod arguments first
			} asDictionary) ] ].

	anAnnounceMethod sourceCode: aMethodSourceCode
]
