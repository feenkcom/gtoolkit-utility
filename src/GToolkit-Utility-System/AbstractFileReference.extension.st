Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-System' }
AbstractFileReference >> osCopyTo: aReference [
	"Copy the receiver to aReference using the OS utility.
	This is faster for larger files, and on linux / Mac preserves meta-data."

	^ self resolve osCopyTo: aReference resolve
]
