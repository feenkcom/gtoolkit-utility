Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Utility-File' }
AbstractFileReference >> asGtFileReferenceWithRanges [
	| fr |

	fr := self resolve.
	^ GtFileReferenceWithRanges fileSystem: fr fileSystem path: fr path
]
