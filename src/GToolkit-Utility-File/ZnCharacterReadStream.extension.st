Extension { #name : #ZnCharacterReadStream }

{ #category : #'*GToolkit-Utility-File' }
ZnCharacterReadStream >> gtIndexOfLineNumbers: aSortedArray [
	"Answer the character index of the supplied lines numbers.
	The supplied collection must be pre-sorted lowest to highest.
	The indexes are relative to the streams current position"
	| lastLineNumber |

	lastLineNumber := 1.
	^ Array streamContents: [ :resultStream |
		aSortedArray do: [ :lineNumber |
			lineNumber - lastLineNumber timesRepeat:
				[ self nextLine ].
			lastLineNumber := lineNumber.
			resultStream nextPut: self position ] ].
]

{ #category : #'*GToolkit-Utility-File' }
ZnCharacterReadStream >> indexOfSubCollection: aString [
	| buffer startIndex |

	buffer := self next: aString size.
	startIndex := 1.
	[ self atEnd ] whileFalse:
		[ buffer = aString ifTrue: [ ^ startIndex ].
		startIndex := startIndex + 1.
		buffer := buffer allButFirst, self next asString. ].
	^ 0
]
