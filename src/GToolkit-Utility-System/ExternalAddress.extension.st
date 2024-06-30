Extension { #name : #ExternalAddress }

{ #category : #'*GToolkit-Utility-System' }
ExternalAddress >> copyFrom: startIndex to: endIndex [
	"Answer a ByteArray containing the receiver's contents from startIndex to endIndex"
	| result size |

	size := endIndex - startIndex + 1.
	result := ByteArray new: size.
	self 
		primitiveCopyFrom: self
		at: startIndex
		to: result
		at: 1
		size: size.
	^ result
]

{ #category : #'*GToolkit-Utility-System' }
ExternalAddress >> replaceWith: aByteArray from: start to: stop [
	"Repace the receiver's contents with the supplied ByteArray from start to stop."

	self
		primitiveCopyFrom: aByteArray 
		at: start 
		to: self
		at: 1 
		size: stop - start + 1
]
