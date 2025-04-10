Class {
	#name : #BaselineOfGToolkitBasicUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitBasicUtility
}

{ #category : #baseline }
BaselineOfGToolkitBasicUtility >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec baseline: 'GToolkitAnnouncerUtility' with: [
			spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].
		spec package: 'GToolkit-Utility-Basic' with: [
			spec requires: #('GToolkitAnnouncerUtility') ] ]
]
