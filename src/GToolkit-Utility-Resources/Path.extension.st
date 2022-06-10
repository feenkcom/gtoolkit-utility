Extension { #name : #Path }

{ #category : #'*GToolkit-Utility-Resources' }
Path >> containsResourceReference: aGtResourceReference [

	^ false
]

{ #category : #'*GToolkit-Utility-Resources' }
Path >> makeRelativeToResourceReference: aGtResourceReference [
	"Return the path of the receiver relative to landmarkReference."

	^ self relativeToPath: aGtResourceReference fullPath
]

{ #category : #'*GToolkit-Utility-Resources' }
Path >> resolveResourceReference: aResource [
	^ aResource
]
