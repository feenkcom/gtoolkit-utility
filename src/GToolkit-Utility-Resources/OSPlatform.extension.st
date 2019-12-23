Extension { #name : #OSPlatform }

{ #category : #'*GToolkit-Utility-Resources' }
OSPlatform >> gtResourceAtPath: aPath using: aGtIcebergUtility [
	"Specific platforms can search resources in other places"
	<return: #FileReference or: nil>
	^ nil
]
