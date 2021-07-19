Class {
	#name : #BaselineOfGToolkitRobocoderUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitRobocoderUtility
}

{ #category : #accessing }
BaselineOfGToolkitRobocoderUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec package: 'GToolkit-Robocoder']
]
