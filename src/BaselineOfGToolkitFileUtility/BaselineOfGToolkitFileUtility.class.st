Class {
	#name : #BaselineOfGToolkitFileUtility,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitFileUtility
}

{ #category : #baseline }
BaselineOfGToolkitFileUtility >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			package: 'GToolkit-Utility-File' with: [ 
				spec requires: #( 'GToolkit-Utility-System' 'GToolkitResourcesUtility' ) ];
			package: 'GToolkit-Utility-URL';
			package: 'GToolkit-Utility-System' with: [ 
				spec requires: #( 'GToolkitAssertionUtility' ) ]
	]
]
