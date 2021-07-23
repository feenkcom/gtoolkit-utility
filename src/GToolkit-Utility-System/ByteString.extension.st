Extension { #name : 'ByteString' }

{ #category : '*GToolkit-Utility-System' }
ByteString >> gtRemoveEmptyLines [
	^ String cr join: (self lines select: [:aLine | aLine notEmpty ])
]
