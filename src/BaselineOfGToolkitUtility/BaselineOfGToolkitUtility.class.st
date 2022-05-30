"
A set of utilities.


"
Class {
	#name : #BaselineOfGToolkitUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitUtility
}

{ #category : #baseline }
BaselineOfGToolkitUtility >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].
		spec
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].
		spec
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].
		spec
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].
		spec
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].
		spec
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.110/src' ].

		spec package: 'GToolkit-Utility-MessageTally'.
		spec package: 'GToolkit-Utility-SpaceTally'.
		spec package: 'GToolkit-Utility-Tests' with: [
			spec requires: #('GToolkitFileUtility') ].
		spec package: 'GToolkit-Utility-Properties'.
		spec package: 'GToolkit-Utility-ClassLoader'.
	]
]
