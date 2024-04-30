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
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitSessionManagerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].
		spec 
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-SpaceTally';
			package: 'GToolkit-Utility-StackOverflow';
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkitFileUtility' ). ];
			package: 'GToolkit-Utility-Logging'  with: [
				spec requires: #('GToolkitFileUtility' ). ];
			package: 'GToolkit-Utility-Properties';
			package: 'GToolkit-Utility-ClassLoader';
			package: 'GToolkit-Utility-UndeclaredReferences';
			package: 'GToolkit-Utility-Git';
			package: 'GToolkit-Utility-GitHub';
			package: 'GToolkit-Utility-ExtensionMethodsAnalysis';
			package: 'GToolkit-Utility-Deprecation';
			package: 'GToolkit-Utility-Algorithms';
			
			package: 'GToolkit-Releaser-Logging-Analysis' with: [
				spec requires: #('GToolkit-Utility-Logging' ). ];
			package: 'GToolkit-Utility-ObjectConnections';
			package: 'GToolkit-Utility-Network' ].
]
