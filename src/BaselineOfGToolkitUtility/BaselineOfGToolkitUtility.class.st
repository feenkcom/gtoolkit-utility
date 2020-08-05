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
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.1/src' ];
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.1/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.1/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.1/src' ].
		spec 
			package: 'GToolkit-Utility-Announcer' with: [
				spec requires: #('GToolkitBasicUtility' ). ];
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-Refactorings';
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkitFileUtility' ). ]. ].

]
