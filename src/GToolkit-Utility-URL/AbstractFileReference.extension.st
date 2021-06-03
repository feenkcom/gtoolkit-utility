Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-URL' }
AbstractFileReference >> asZnRelativeUrl [ 
	"Convert the receiver in a file:// ZnUrl.
	Note that this breaks the standard, but is useful for creating URLs with different schemes"

	^ self resolve path asZnRelativeUrl
]
