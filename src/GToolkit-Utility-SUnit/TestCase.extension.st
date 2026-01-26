Extension { #name : #TestCase }

{ #category : #'*GToolkit-Utility-SUnit' }
TestCase >> gtRunWithExplicitResult [
	| testWithResult |
	testWithResult := GtSUnitTestWithResult new
		testCase: self.
	testWithResult run.
	^ testWithResult 
]
