Class {
	#name : #ManifestGToolkitUtilityAnnouncer,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Utility-Announcer-Manifest'
}

{ #category : #asserting }
ManifestGToolkitUtilityAnnouncer class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
	}
]

{ #category : #asserting }
ManifestGToolkitUtilityAnnouncer class >> mustOnlyDependOn [
	^ {'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Support'.
		'GToolkit-Utility-Basic'.
		'Kernel'.
		'Network-UUID'.
		'System-Finalization'.
		'Kernel'.
	}
]

{ #category : #asserting }
ManifestGToolkitUtilityAnnouncer class >> shouldDependOn [
	^ {}
]
