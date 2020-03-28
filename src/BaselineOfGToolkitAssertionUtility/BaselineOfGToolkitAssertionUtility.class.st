Class {
	#name : #BaselineOfGToolkitAssertionUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitAssertionUtility
}

{ #category : #baseline }
BaselineOfGToolkitAssertionUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'GToolkit-Utility-Assertion' ]
]
