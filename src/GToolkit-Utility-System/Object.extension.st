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
Object class >> gtGroupType [
	^ GtBasicGroup
]

{ #category : #'*GToolkit-Utility-System' }
Object >> gtMemcpyAddress [
	"Answer the object that will be passed to primitiveCopyFromAtToAtSize"

	^ self
]

{ #category : #'*GToolkit-Utility-System' }
Object >> gtUpToVersion: versionString currentVersion: currentString do: upToBlock after: afterBlock [
	"Evaluate upToBlock if versionString <= currentString, otherwise afterBlock.
	versionString and currentString are semantic version numbers with an optional leading $v.
	This is used to help with migration where a target image may not be synchronised with all local changes."
	| currentVersion version |

	currentVersion := GtRlSemanticVersionNumber readFromString: currentString.
	version := GtRlSemanticVersionNumber readFromString: versionString.
	^ (currentVersion <= version)
		ifTrue: upToBlock
		ifFalse: afterBlock.
]

{ #category : #'*GToolkit-Utility-System' }
Object >> gtUpToVersion: versionString do: upToBlock after: afterBlock [
	"Evaluate upToBlock if versionString <= current bundle version, otherwise afterBlock.
	versionString and currentString are semantic version numbers with an optional leading $v.
	This is used to help with migration where a target image may not be synchronised with all local changes."

	^ self
		gtUpToVersion: versionString 
		currentVersion: GtImage version versionString
		do: upToBlock 
		after: afterBlock.
]
