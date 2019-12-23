Extension { #name : #MacOSXPlatform }

{ #category : #'*GToolkit-Utility-File' }
MacOSXPlatform >> gtResourceAtPath: aPath using: aGtIcebergUtility [
	"Specific platforms can search resources in other places"
	^ aGtIcebergUtility resourceAtMacOSResourcesDirectory: aPath
]
