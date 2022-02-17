Extension { #name : #FileReference }

{ #category : #'*GToolkit-Utility-Resources' }
FileReference >> containsResourceReference: aGtResourceReference [

	^ aGtResourceReference fileSystem = filesystem and: [ 
		  self path contains: aGtResourceReference fileReference path ]
]
