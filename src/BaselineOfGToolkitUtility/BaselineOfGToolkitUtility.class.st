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
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].
		spec
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].
		spec
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].
		spec
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].
		spec
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].
		spec
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.178/src' ].

		spec package: 'GToolkit-Utility-MessageTally'.
		spec package: 'GToolkit-Utility-SpaceTally'.
		spec package: 'GToolkit-Utility-Tests' with: [
			spec requires: #('GToolkitFileUtility') ].
		spec package: 'GToolkit-Utility-Logging' with: [
			spec requires: #('GToolkitFileUtility') ].
		spec package: 'GToolkit-Utility-Properties'.
		spec package: 'GToolkit-Utility-ClassLoader'.
		spec package: 'GToolkit-Utility-UndeclaredReferences'.
		spec package: 'GToolkit-Utility-GitHub'.
		spec package: 'GToolkit-Utility-ExtensionMethodsAnalysis'.
		spec package: 'GToolkit-Utility-Deprecation'.
		spec package: 'GToolkit-Releaser-Logging-Analysis' with: [
			spec requires: #('GToolkit-Utility-Logging') ].
	]
]
