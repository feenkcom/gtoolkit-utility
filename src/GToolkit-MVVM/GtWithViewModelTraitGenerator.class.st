"
! View Model Trait generator
"
Class {
	#name : #GtWithViewModelTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'modelName',
		'projectPrefix',
		'packageName'
	],
	#classVars : [
		'__VIEW_MODEL_SLOT__'
	],
	#category : #'GToolkit-MVVM'
}

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __HAS_VIEW_MODEL__ [
	"Return a true if __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ __VIEW_MODEL_SLOT__ notNil
]

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __SUBSCRIBE_TO_VIEW_MODEL_HOOK__ [
	"Is sent after a new __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the element.
	It is required to unsubscribe from the __MODEL_NAME_SUFFIX__ or domain model by implementing
	#__UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ if elements subscribe to them"
]

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ [
	"Is sent before a new __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the element.
	Elements that subscribe to __MODEL_NAME__ __MODEL_NAME_SUFFIX__ in domain model are required to implement this methods"
]

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __VIEW_MODEL_CHANGED_HOOK__ [
	"Is sent when a new __MODEL_NAME__ __MODEL_NAME_SUFFIX__ is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __VIEW_MODEL_SLOT__ [
	"Return a not-null __MODEL_NAME__ __MODEL_NAME_SUFFIX__ assigned to the receiver"
	self
		assert: [ __VIEW_MODEL_SLOT__ notNil ]
		description: [ '__MODEL_NAME__ __MODEL_NAME_SUFFIX__ should be initialized' ].

	^ __VIEW_MODEL_SLOT__
]

{ #category : #'private - template' }
GtWithViewModelTraitGenerator >> __VIEW_MODEL_SLOT__: a__MODEL_NAME__ViewModel [
	"Set a not-null __MODEL_NAME__ __MODEL_NAME_SUFFIX__ assigned to the receiver"
	self
		assert: [ a__MODEL_NAME__ViewModel notNil ]
		description: [ '__MODEL_NAME__ __MODEL_NAME_SUFFIX__ must not be nil' ].

	__VIEW_MODEL_SLOT__ == a__MODEL_NAME__ViewModel 
		ifTrue: [ ^ self ].

	__VIEW_MODEL_SLOT__ ifNotNil: [ self __UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ ].
	__VIEW_MODEL_SLOT__ := a__MODEL_NAME__ViewModel.

	self __VIEW_MODEL_CHANGED_HOOK__.
	self __SUBSCRIBE_TO_VIEW_MODEL_HOOK__
]

{ #category : #generation }
GtWithViewModelTraitGenerator >> createMethodsIn: aTrait [
	| templateMethods templateMap |
	
	templateMethods := { 
		self class lookupSelector: #__VIEW_MODEL_SLOT__.
		self class lookupSelector: #__VIEW_MODEL_SLOT__:.
		self class lookupSelector: #__VIEW_MODEL_CHANGED_HOOK__.
		self class lookupSelector: #__HAS_VIEW_MODEL__.
		self class lookupSelector: #__SUBSCRIBE_TO_VIEW_MODEL_HOOK__.
		self class lookupSelector: #__UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__.
	}.
	templateMap := { 
		#__MODEL_NAME__ -> self modelName capitalized.
		#__MODEL_NAME_SUFFIX__ -> self modelNameSuffixInText.
		#__VIEW_MODEL_SLOT__ -> self slotName.
		#__HAS_VIEW_MODEL__ -> self hasViewModelName.
		#__VIEW_MODEL_CHANGED_HOOK__ -> self viewModelChangedName.
		#__SUBSCRIBE_TO_VIEW_MODEL_HOOK__ -> self subscribeToName.
		#__UNSUBSCRIBE_FROM_VIEW_MODEL_HOOK__ -> self unsubscribeFromName
	}.
	
	templateMethods do: [ :eachTemplateMethod |
		| methodSource |
		
		methodSource := eachTemplateMethod sourceCode.
		templateMap do: [ :eachAssociation | methodSource := methodSource copyReplaceAll: eachAssociation key with: eachAssociation value ].
		aTrait compile: methodSource classified: self methodProtocolName ]
]

{ #category : #generation }
GtWithViewModelTraitGenerator >> createTrait [
	<return: #Trait>
	
	^ Trait named: self traitName
		uses: {}
		slots: { self slotName }
		package: self packageName
]

{ #category : #generation }
GtWithViewModelTraitGenerator >> generate [
	| aNewTrait |

	aNewTrait := self createTrait.
	self createMethodsIn: aNewTrait.
	^ aNewTrait
]

{ #category : #private }
GtWithViewModelTraitGenerator >> hasViewModelName [
	^ ('has', self slotName asString capitalized) asSymbol
]

{ #category : #private }
GtWithViewModelTraitGenerator >> methodProtocolName [
	^ self methodProtocolPattern format: {
		String streamContents: [ :aStream | 
			self modelName gtPiecesCutWhereCamelCase 
				do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
				separatedBy: [ aStream nextPut: Character space ] ] }
]

{ #category : #private }
GtWithViewModelTraitGenerator >> methodProtocolPattern [
	^ 'api - {1} view model'
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> modelName [
	^ modelName
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> modelName: anObject [
	modelName := anObject
]

{ #category : #private }
GtWithViewModelTraitGenerator >> modelNameSuffix [
	^ 'ViewModel'
]

{ #category : #private }
GtWithViewModelTraitGenerator >> modelNameSuffixInText [
	^ String streamContents: [ :aStream | 
			self modelNameSuffix gtPiecesCutWhereCamelCase
				do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
				separatedBy: [ aStream nextPut: Character space ] ]
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #private }
GtWithViewModelTraitGenerator >> slotName [
	^ (self modelName uncapitalized, self modelNameSuffix) asSymbol
]

{ #category : #private }
GtWithViewModelTraitGenerator >> subscribeToName [
	^ ('subscribeTo', self slotName asString capitalized) asSymbol
]

{ #category : #private }
GtWithViewModelTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self modelName capitalized;
			nextPutAll: self modelNameSuffix ]
]

{ #category : #private }
GtWithViewModelTraitGenerator >> unsubscribeFromName [
	^ ('unsubscribeFrom', self slotName asString capitalized) asSymbol
]

{ #category : #private }
GtWithViewModelTraitGenerator >> viewModelChangedName [
	^ ('on', self slotName asString capitalized, 'Changed') asSymbol
]
