Class {
	#name : #BaselineOfGToolkitFileUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitFileUtility
}

{ #category : #baseline }
BaselineOfGToolkitFileUtility >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.13/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.13/src' ].
		spec 
			package: 'GToolkit-Utility-URL';
			package: 'GToolkit-Utility-System' with: [
				spec requires: #('GToolkitAssertionUtility' ). ];
			package: 'GToolkit-Utility-File' with: [
				spec requires: #('GToolkit-Utility-System' 'GToolkitResourcesUtility' ). ]. ].

]
