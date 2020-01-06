Extension { #name : #OSPlatform }

{ #category : #'*GToolkit-Utility-Resources' }
OSPlatform >> gtResourceAtPath: aPath using: aGtResourcesUtilityLocation [
	"Specific platforms can search resources in other places"
	<return: #GtResourcesUtilityLocationResult>
	^ GtResourcesUtilityLocationResult null
]
