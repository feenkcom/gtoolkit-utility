Extension { #name : #ExternalObject }

{ #category : #'*GToolkit-Utility-System' }
ExternalObject >> gtMemcpyAddress [
	"Answer the object that will be passed to primitiveCopyFromAtToAtSize"

	^ self getHandle gtMemcpyAddress
]
