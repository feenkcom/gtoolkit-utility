Extension { #name : #LibC }

{ #category : #'*GToolkit-Utility-System' }
LibC >> ffiMemCopy: src to: dest size: n [
	^ self
		ffiCall: #(#void #* #memcpy #(#void #* #dest #, #const #void #* #src #, #size_t #n))
]

{ #category : #'*GToolkit-Utility-System' }
LibC >> memCopy: src to: dest size: n [
	"Copy n bytes from the src to the dest.
	Uses primitiveCopyFromAtToAtSize to minimise the need to pin objects in old space (which can be very slow).
	If you don't need to pin dest, using the copy methods in ByteArray and ExternalAddress will be more efficient."

	ByteArray
		primitiveCopyFrom: src gtMemcpyAddress
		at: 1
		to: dest gtMemcpyAddress
		at: 1
		size: n.
	^ dest tfPointerAddress
]
