Class {
	#name : #ManifestGToolkitUtilityResources,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Utility-Resources-Manifest'
}

{ #category : #asserting }
ManifestGToolkitUtilityResources class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
	}
]

{ #category : #asserting }
ManifestGToolkitUtilityResources class >> mustOnlyDependOn [
	^ {'AST-Core'.
		'Collections-Sequenceable'.
		'FileSystem-Core'.
		'FileSystem-Path'.
		'Iceberg-Libgit'.
		'Kernel'.
		'System-Platforms'}
]

{ #category : #asserting }
ManifestGToolkitUtilityResources class >> shouldDependOn [
	^ {}
]
