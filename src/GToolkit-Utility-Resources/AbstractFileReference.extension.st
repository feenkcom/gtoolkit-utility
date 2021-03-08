Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-Resources' }
AbstractFileReference >> gtWithClosestFileLocatorParent [
	^ GtResourceClosestFileLocator new
		file: self;
		find
]
