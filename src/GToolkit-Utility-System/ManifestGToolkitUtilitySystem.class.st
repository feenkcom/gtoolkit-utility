Class {
	#name : #ManifestGToolkitUtilitySystem,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Utility-System-Manifest'
}

{ #category : #asserting }
ManifestGToolkitUtilitySystem class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
		'GToolkit-Releaser'.
		'GToolkit-Utility-System-UI'
	}
]

{ #category : #asserting }
ManifestGToolkitUtilitySystem class >> shouldDependOn [
	^ {}
]
