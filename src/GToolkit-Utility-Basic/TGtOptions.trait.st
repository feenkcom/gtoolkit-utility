Trait {
	#name : #TGtOptions,
	#instVars : [
		'options'
	],
	#category : #'GToolkit-Utility-Basic-Traits'
}

{ #category : #'options - basic' }
TGtOptions >> assertOptionDoesNotExist: aKey [
	self 
		assert: [ (self hasOptionAt: aKey) not ]
		description: [ String streamContents: [ :aStream | 
			aStream 
				nextPutAll: 'Key should not exist: ';
				print: aKey ] ]
]

{ #category : #'options - basic' }
TGtOptions >> ensureOptions [
	options ifNil: [ options := Dictionary new ]
]

{ #category : #'options - basic' }
TGtOptions >> hasOptionAt: aKey [
	<return: #Boolean>
	^ self hasOptions and: [ 
		self 
			optionAt: aKey 
			ifPresent: [ :aValue | true ] 
			ifAbsent: [ false ] ]
]

{ #category : #'options - basic' }
TGtOptions >> hasOptions [
	<return: #Boolean>
	^ options isNotNil and: [ options isNotEmpty ]
]

{ #category : #'options - basic' }
TGtOptions >> optionAt: aKey ifAbsent: anAbsentBlock [
	"Return my option/settings stored under key.
	Execute block if I have no such option/setting."

	self hasOptions ifFalse: [ ^ anAbsentBlock value ].
	^ options at: aKey ifAbsent: anAbsentBlock
]

{ #category : #'options - basic' }
TGtOptions >> optionAt: aKey ifAbsentPut: anAbsentBlock [
	"Return my option/settings stored under key.
	If I have no such option/setting, store the result of evaluating block as new value and return it."

	self ensureOptions.
	^ options at: aKey ifAbsentPut: anAbsentBlock
]

{ #category : #'options - basic' }
TGtOptions >> optionAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	"Return my option/settings stored under key.
	Execute block if I have no such option/setting."

	self hasOptions ifFalse: [ ^ anAbsentBlock value ].
	^ options at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'options - basic' }
TGtOptions >> optionAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	"Return my option/settings stored under key.
	If I have no such option/setting, store the result of evaluating block as new value and return it."

	self ensureOptions.
	^ options at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #'options - basic' }
TGtOptions >> optionAt: aKey put: aValue [
	"Set my option/setting identified by key to be value."

	self ensureOptions.
	options at: aKey put: aValue
]
