Extension { #name : #MacOSXPlatform }

{ #category : #'*GToolkit-Utility-Resources' }
MacOSXPlatform >> gtResourceAtPath: aPath using: aGtIcebergUtility [
	"Specific platforms can search resources in other places"
	^ aGtIcebergUtility resourceAtMacOSResourcesDirectory: aPath
]
