Extension { #name : #Number }

{ #category : #'*GToolkit-Utility-System' }
Number >> asStringWithCommas [
	^ (self round: 0) asInteger asStringWithCommas
]

{ #category : #'*GToolkit-Utility-System' }
Number class >> gtReadAllFrom: stringOrStream [ 
	"Answer a number read from stringOrStream.
	The number may be any accepted Smalltalk literal Number format, 
	but may not have any trailing characters.
	It can include a leading radix specification, as in 16rFADE.
	It can be NaN, Infinity or -Infinity.
	If stringOrStream does not start with a valid number description, fail.
	If the entire stream is not consumed, fail"
	| stream n |

	stream := stringOrStream readStream.
	n := (NumberParser on: stream) nextNumber.
	stream atEnd ifFalse:
		[ self error: 'Reading a number failed: Entire stream not consumed' ].
	^ n.
]
