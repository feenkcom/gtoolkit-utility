Extension { #name : #Integer }

{ #category : #'*GToolkit-Utility-System' }
Integer >> humanReadableIsqByteSize [
	^ String streamContents: [ :s|
		self humanReadableIsqByteSizeOn: s ]
]

{ #category : #'*GToolkit-Utility-System' }
Integer >> humanReadableIsqByteSizeOn: s [
	| exponent base |
	"Print a string with an SI binary unit represation of myself."
	base := 1024.
	self < base
		ifTrue: [ ^ s print: self; space; nextPut: $B ].
	exponent := (self log / base log) asInteger.
	(self / (base ** exponent)) printOn: s showingDecimalPlaces: 2.
	s 
		space;
		nextPutAll: (#(KiB MiB GiB TiB PiB EiB) at: exponent).

]
