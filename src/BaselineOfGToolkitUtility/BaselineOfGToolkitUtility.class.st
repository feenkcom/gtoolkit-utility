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
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ];
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ];
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ];
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.9/src' ].
		spec 
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkitFileUtility' ). ]. ].

]
