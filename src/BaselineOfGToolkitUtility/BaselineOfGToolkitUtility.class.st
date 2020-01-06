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
		spec baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.10/src' ].
		spec 
			package: 'GToolkit-Utility-File' with: [
				spec requires: #('GToolkitResourcesUtility' ). ];
			package: 'GToolkit-Utility-Assertion';
			package: 'GToolkit-Utility-Announcer';
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-System' with: [
				spec requires: #('GToolkit-Utility-Assertion' ). ];
			package: 'GToolkit-Utility-Tasker' with: [
				spec requires: #('GToolkit-Utility-Assertion' ). ];
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkit-Utility-System' ). ]. ].

]
