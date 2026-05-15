Extension { #name : #Object }

{ #category : #'*GToolkit-Utility-System' }
Object >> gtClassOrTraitFrom: aCollection [
	"Answer the first class or trait found from the supplied collection of names (Symbols).
	This is used to help with migration where a target image may not be synchronised with all local changes."

	aCollection do: [ :classNameSymbol |
		self class environment
			at: classNameSymbol
			ifPresent: [ :cls | ^ cls ] ].
	self error: 'Class or Trait not found'.
]

{ #category : #'*GToolkit-Utility-System' }
Object >> gtMemcpyAddress [
	"Answer the object that will be passed to primitiveCopyFromAtToAtSize"

	^ self
]

{ #category : #'*GToolkit-Utility-System' }
Object >> notYetTested [
	"Announce that this message is not yet tested"
	<debuggerCompleteToSender>
	NotYetTested signalFor: thisContext sender selector
]
