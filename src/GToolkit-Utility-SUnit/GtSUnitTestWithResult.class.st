Class {
	#name : #GtSUnitTestWithResult,
	#superclass : #Object,
	#instVars : [
		'testCase',
		'result'
	],
	#category : #'GToolkit-Utility-SUnit'
}

{ #category : #views }
GtSUnitTestWithResult >> gtSourceCodeFor: aView [
	<gtView>
	^(aView forward)
		title: 'Source';
		priority: 5;
		object: [testCase];
		view: #gtSourceCodeFor:
]

{ #category : #views }
GtSUnitTestWithResult >> gtViewExampleComparisonFailureDiffFor: aView [
	<gtView>

	self isGtComparisonFailureExample	ifFalse: [ ^ aView empty ].
	
	^(aView forward)
		title: 'Comparison Diff';
		priority: 6;
		object: [ self result ];
		view: #gtViewExampleComparisonFailureDiffFor:
]

{ #category : #views }
GtSUnitTestWithResult >> gtViewExceptionMessageFor: aView [
	<gtView>
	(self isError or: [ self isFailure ]) ifFalse: [ ^ aView empty ].
	^(aView forward)
		title: 'Exception message';
		priority: 15;
		object: [result];
		view: #gtExceptionMessageFor:
]

{ #category : #views }
GtSUnitTestWithResult >> gtViewExceptionStackFor: aView [
	<gtView>
	(self isError or: [ self isFailure ]) ifFalse: [ ^ aView empty ].
	^(aView forward)
		title: 'Exception stack';
		priority: 15;
		object: [result];
		view: #gtExceptionStackFor:
]

{ #category : #testing }
GtSUnitTestWithResult >> hasResult [
	^ result notNil
]

{ #category : #testing }
GtSUnitTestWithResult >> isError [
	^ self hasResult and: [ self result isError ]
]

{ #category : #testing }
GtSUnitTestWithResult >> isFailure [
	^ self hasResult and: [ self result isFailure ]
]

{ #category : #views }
GtSUnitTestWithResult >> isGtComparisonFailureExample [
	^ self hasResult and: [
			self result isGtComparisonFailureExample ]
]

{ #category : #testing }
GtSUnitTestWithResult >> isSuccess [
	^ self hasResult and: [ self result isSuccess ]
]

{ #category : #'as yet unclassified' }
GtSUnitTestWithResult >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< result state;
			<< '; ';
			print: self testCase ]
]

{ #category : #accessing }
GtSUnitTestWithResult >> result [
	^result
]

{ #category : #accessing }
GtSUnitTestWithResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtSUnitTestWithResult >> run [
	result := GtSUnitTestResult new.
	result testCase: testCase.
	[ result runCase ] ensure: [ ].
	^result
]

{ #category : #accessing }
GtSUnitTestWithResult >> selector [
	^ testCase selector
]

{ #category : #accessing }
GtSUnitTestWithResult >> testCase [
	^testCase
]

{ #category : #accessing }
GtSUnitTestWithResult >> testCase: anObject [
	testCase := anObject
]
