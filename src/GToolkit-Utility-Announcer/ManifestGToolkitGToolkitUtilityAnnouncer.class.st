Class {
	#name : #ManifestGToolkitGToolkitUtilityAnnouncer,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Utility-Announcer-Manifest'
}

{ #category : #asserting }
ManifestGToolkitGToolkitUtilityAnnouncer class >> mustNotDependOn [
	^ { 
		'Bloc'.
		'Brick'.
	}
]

{ #category : #asserting }
ManifestGToolkitGToolkitUtilityAnnouncer class >> mustOnlyDependOn [
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
ManifestGToolkitGToolkitUtilityAnnouncer class >> shouldDependOn [
	^ {}
]
