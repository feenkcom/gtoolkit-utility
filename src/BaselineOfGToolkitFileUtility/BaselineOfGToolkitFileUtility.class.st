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
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'FFICHeaderExtractor' with: [
				spec repository: 'github://pharo-contributions/FFICHeaderExtractor:v1.0.2/repository' ].
		spec 
			package: 'GToolkit-Utility-URL';
			package: 'GToolkit-Utility-System' with: [
				spec requires: #('GToolkitAssertionUtility' 'FFICHeaderExtractor'). ];
			package: 'GToolkit-Utility-File' with: [
				spec requires: #('GToolkit-Utility-System' 'GToolkitResourcesUtility' ). ]. ].

]
