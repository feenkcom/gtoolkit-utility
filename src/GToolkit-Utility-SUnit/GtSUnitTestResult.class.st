Class {
	#name : #GtSUnitTestResult,
	#superclass : #Object,
	#instVars : [
		'testCase',
		'exception',
		'state'
	],
	#category : #'GToolkit-Utility-SUnit'
}

{ #category : #adding }
GtSUnitTestResult >> addError: aTestCase [
	"API compatible with TestResult"
	state := 'error'
]

{ #category : #adding }
GtSUnitTestResult >> addFailure: aTestCase [
	"API compatible with TestResult"
	state := 'failure'
]

{ #category : #adding }
GtSUnitTestResult >> addPass: aTestCase [
	"API compatible with TestResult"
	state := 'pass'
]

{ #category : #adding }
GtSUnitTestResult >> addSkip: aTestCase [
	"API compatible with TestResult"
	state := 'skip'
]

{ #category : #accessing }
GtSUnitTestResult >> exception [
	^exception
]

{ #category : #views }
GtSUnitTestResult >> gtExceptionMessageFor: aView [
	<gtView>
	exception ifNil: [ ^aView empty ].
	
	^(aView forward)
		title: 'Exception message';
		priority: 15;
		object: [exception];
		view: #gtMessageTextFor:
]

{ #category : #views }
GtSUnitTestResult >> gtExceptionStackFor: aView [
	<gtView>
	exception ifNil: [ ^aView empty ].
	^(aView forward)
		title: 'Exception stack';
		priority: 10;
		object: [exception];
		view: #gtLiveFor:
]

{ #category : #views }
GtSUnitTestResult >> gtSourceCodeFor: aView [
	<gtView>
	^(aView forward)
		title: 'Source';
		object: [testCase];
		view: #gtSourceCodeFor:
]

{ #category : #testing }
GtSUnitTestResult >> isError [
	^state = 'error'
]

{ #category : #testing }
GtSUnitTestResult >> isError: aTestCase [
	"API compatible with TestResult"
	^ self isError and:  [testCase = aTestCase]
]

{ #category : #testing }
GtSUnitTestResult >> isExpectedDefect [
	"Indicates if the test was expected to not pass. See (<expectedFailure> pragma)"

	^  self testCase shouldPass not
]

{ #category : #testing }
GtSUnitTestResult >> isFailure [
	^state = 'failure'
]

{ #category : #testing }
GtSUnitTestResult >> isFailure: aTestCase [
	"API compatible with TestResult"
	^ self ifFailure and: [testCase = aTestCase ]
]

{ #category : #testing }
GtSUnitTestResult >> isPassed [
	^state = 'pass'
]

{ #category : #testing }
GtSUnitTestResult >> isPassed: aTestCase [
	"API compatible with TestResult"
	^ self isPassed and: [testCase = aTestCase ]
]

{ #category : #testing }
GtSUnitTestResult >> isSkipped [
	^state = 'skip'
]

{ #category : #printing }
GtSUnitTestResult >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< state;
			<< '; ';
			print: self testCase;
			<< '; ';
			print: exception ]
]

{ #category : #running }
GtSUnitTestResult >> runCase [
	[
	testCase announce: TestCaseStarted withResult: self.
	testCase runCaseManaged.
	testCase announce: TestCaseEnded  withResult: self.
	self addPass: testCase]
		on: TestResult failure 
			, TestResult skip
			, TestResult warning
			, TestResult error
		do: [:anException | 
			exception := (GtSystemUtility freeze: anException).
			anException sunitAnnounce: testCase toResult: self]
]

{ #category : #accessing }
GtSUnitTestResult >> state [
	^state
]

{ #category : #accessing }
GtSUnitTestResult >> testCase [
	^testCase
]

{ #category : #accessing }
GtSUnitTestResult >> testCase: anObject [
	testCase := anObject
]
