Trait {
	#name : #TGtAssert,
	#category : #'GToolkit-Utility-Assertion'
}

{ #category : #asserting }
TGtAssert classSide >> assert: aBlock [
	self 
		assert: aBlock 
		description: [ AssertionFailure signal: 'Assertion failed' ]
]

{ #category : #asserting }
TGtAssert classSide >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	We check for true explicitly to make the assertion fail for non booleans."
	
	self isAssertionEnabled
		ifTrue: [ (aBlock value == true) ifFalse: [ 
				AssertionFailure signal: aStringOrBlock value ] ]
]

{ #category : #testing }
TGtAssert classSide >> isAssertionEnabled [
	"Return true if assertions should be executed"
	<return: #Boolean>
	^ GtAssertionSettings isAssertionEnabled
]

{ #category : #asserting }
TGtAssert >> assert: aBlock [
	self class assert: aBlock
]

{ #category : #asserting }
TGtAssert >> assert: aBlock description: aStringOrBlock [
	self class assert: aBlock description: aStringOrBlock
]
