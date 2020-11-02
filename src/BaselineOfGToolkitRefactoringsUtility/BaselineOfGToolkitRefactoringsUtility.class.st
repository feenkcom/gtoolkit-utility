Class {
	#name : #BaselineOfGToolkitRefactoringsUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitRefactoringsUtility
}

{ #category : #baseline }
BaselineOfGToolkitRefactoringsUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'GToolkit-Utility-Refactorings' ]
]
