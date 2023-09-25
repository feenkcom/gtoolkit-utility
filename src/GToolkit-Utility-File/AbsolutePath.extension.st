Extension { #name : #AbsolutePath }

{ #category : #'*GToolkit-Utility-File' }
AbsolutePath class >> addParentElementTo: result on: filesystem [
	"The parent directory may be a symbolic link, in which case it must be resolved to its target path before determining the result."
	<gtPharoPatch: #Pharo12>

	result ifNotEmpty:
		[ | parentReference entry |
		parentReference := filesystem referenceTo: (self withAll: result).
		entry := parentReference symlinkEntry.
		entry isSymlink ifTrue:
			[ result removeAll.
			result addAll: entry targetPath segments ] ].

	(result isEmpty or: [ result last = '..' ])
		ifTrue: [ result add: '..' ]
		ifFalse: [ result removeLast ]
]

{ #category : #'*GToolkit-Utility-File' }
AbsolutePath class >> removeRedundantSegments: segments [
	"Remove redundant elements ('.' and '') from the supplied segments.
	The parent of the root directory is itself."
	| newSegments |

	newSegments := segments asOrderedCollection copy.
	[ newSegments isNotEmpty and: [ newSegments first = '..' ] ] whileTrue:
		[ newSegments removeFirst ].
	^ newSegments select:
		[ :segment | segment notEmpty and: [ segment ~= '.' ] ]
]
