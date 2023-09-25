Extension { #name : #AbsolutePath }

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
