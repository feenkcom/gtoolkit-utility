Extension { #name : #MacOSXPlatform }

{ #category : #'*GToolkit-Utility-Resources' }
MacOSXPlatform >> gtResourceAtPath: aPath using: aGtResourcesUtilityLocation [
	"Specific platforms can search resources in other places"
	^ aGtResourcesUtilityLocation resourceAtMacOSResourcesDirectory: aPath
]
