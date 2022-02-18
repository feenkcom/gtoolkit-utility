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
AbstractFileReference >> resolveResourceReference: aResource [

	<return: #AbstractFileReference>
	^ self fileSystem = aResource fileSystem
		  ifTrue: [ 
		  	self copyWithPath: (self path resolvePath: aResource relativePath) ]
		  ifFalse: [ aResource ]
]
