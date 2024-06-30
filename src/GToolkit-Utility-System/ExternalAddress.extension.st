Extension { #name : #ExternalAddress }

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
