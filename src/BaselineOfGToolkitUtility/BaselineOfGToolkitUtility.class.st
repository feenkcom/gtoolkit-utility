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
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.35/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.35/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.7.35/src' ].
		spec 
			package: 'GToolkit-Utility-Announcer';
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-Refactorings';
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkitFileUtility' ). ]. ].

]
