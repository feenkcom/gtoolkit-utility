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
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.9.36/src' ].
		spec
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.9.36/src' ].
		spec
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.9.36/src' ].
		spec
			baseline: 'Futures' with: [
				spec repository: 'github://feenkcom/pharo-futures:v0.6.161/src' ].
		spec
			baseline: 'FFICHeaderExtractor' with: [
				spec repository: 'github://pharo-contributions/FFICHeaderExtractor:v1.0.2/repository' ].

		spec package: 'GToolkit-Utility-URL'.
		spec package: 'GToolkit-Utility-System' with: [
			spec requires: #(#GToolkitAssertionUtility #FFICHeaderExtractor #GToolkitResourcesUtility #GToolkitAnnouncerUtility #Futures) ].
		spec package: 'GToolkit-Utility-System-UI' with: [
			spec requires: #(#'GToolkit-Utility-System') ].
		spec package: 'GToolkit-Utility-File' with: [
			spec requires: #(#'GToolkit-Utility-System' #GToolkitResourcesUtility) ].
	]
]
