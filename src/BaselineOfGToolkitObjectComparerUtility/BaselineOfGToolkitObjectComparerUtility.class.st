Class {
	#name : #BaselineOfGToolkitObjectComparerUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitObjectComparerUtility
}

{ #category : #baseline }
BaselineOfGToolkitObjectComparerUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'GToolkit-Utility-ObjectComparer' ]
]
