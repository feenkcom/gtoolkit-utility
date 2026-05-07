Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> gtWithClosestFileLocatorParent [
	^ GtResourceClosestFileLocator new
		file: self;
		transform
]

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> isEqualToResourceReference: aGtResourceReference [

	^ self asFileReference = aGtResourceReference fileReference
]

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> makeRelativeToResourceReference: aGtResourceReference [
	"Return the path of the receiver relative to landmarkReference."

	^ self fullPath relativeTo: aGtResourceReference fullPath
]

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> resolveResourceReference: aResource [
	<return: #AbstractFileReference>
	^ self fileSystem = aResource fileSystem
		ifTrue: [ | myPath itsRelativePath |
			myPath := self path.
			itsRelativePath := aResource relativePath.
			myPath = itsRelativePath ifTrue: [ ^ aResource ].
			(myPath containsPath: itsRelativePath) ifTrue: [ ^ aResource ].
			(itsRelativePath containsPath: myPath) ifTrue: [ ^ aResource ].
			self copyWithPath: (myPath resolvePath: itsRelativePath) ]
		ifFalse: [ aResource ]
]
