Class {
	#name : #BaselineOfGToolkitAnnouncerUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitAnnouncerUtility
}

{ #category : #baseline }
BaselineOfGToolkitAnnouncerUtility >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.34/src' ].
		spec package: 'GToolkit-Utility-Announcer' with: [
				spec requires: #('GToolkitBasicUtility' ). ]. ].

]
