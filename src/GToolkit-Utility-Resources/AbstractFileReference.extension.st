Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> gtWithClosestFileLocatorParent [
	^ GtResourceClosestFileLocator new
		file: self;
		transform
]

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> resolveResourceReference: aResource [

	<return: #AbstractFileReference>
	^ self fileSystem = aResource fileSystem
		  ifTrue: [ 
		  	self copyWithPath: (self path resolvePath: aResource path) ]
		  ifFalse: [ aResource ]
]
