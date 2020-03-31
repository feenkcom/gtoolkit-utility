Trait {
	#name : #TGtOptions,
	#instVars : [
		'options'
	],
	#category : #'GToolkit-Utility-Basic-Traits'
}

{ #category : #'accessing - options - basic' }
TGtOptions >> ensureOptions [
	options ifNil: [ options := Dictionary new ]
]

{ #category : #'accessing - options - basic' }
TGtOptions >> optionAt: aKey ifAbsent: anAbsentBlock [
	"Return my option/settings stored under key.
	Execute block if I have no such option/setting."

	options ifNil: [ ^ anAbsentBlock value ].
	^ options at: aKey ifAbsent: anAbsentBlock
]

{ #category : #'accessing - options - basic' }
TGtOptions >> optionAt: aKey ifAbsentPut: anAbsentBlock [
	"Return my option/settings stored under key.
	If I have no such option/setting, store the result of evaluating block as new value and return it."

	self ensureOptions.
	^ options at: aKey ifAbsentPut: anAbsentBlock
]

{ #category : #'accessing - options - basic' }
TGtOptions >> optionAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	"Return my option/settings stored under key.
	Execute block if I have no such option/setting."

	options ifNil: [ ^ anAbsentBlock value ].
	^ options at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'accessing - options - basic' }
TGtOptions >> optionAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	"Return my option/settings stored under key.
	If I have no such option/setting, store the result of evaluating block as new value and return it."

	self ensureOptions.
	^ options at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #'accessing - options - basic' }
TGtOptions >> optionAt: aKey put: aValue [
	"Set my option/setting identified by key to be value."

	self ensureOptions.
	options at: aKey put: aValue
]
