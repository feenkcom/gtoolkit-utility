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
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			package: 'GToolkit-Utility-Announcer';
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-Tasker' with: [
				spec requires: #( 'GToolkitAssertionUtility' ) ];
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #( 'GToolkitFileUtility' ) ]
	]

]
