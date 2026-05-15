Extension { #name : #Object }

{ #category : #'*GToolkit-Utility-System-UI' }
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

{ #category : #'*GToolkit-Utility-System-UI' }
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
