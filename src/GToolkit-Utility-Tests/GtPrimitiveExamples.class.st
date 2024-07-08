Class {
	#name : #GtPrimitiveExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #private }
GtPrimitiveExamples >> eaCopy: anExternalAddress from: startIndex to: endIndex [
	"Answer the equivalent of ExternalAddress>>copyFrom:to:, but avoid relying on the new primitive"
	| result size |
	size := endIndex - startIndex + 1.
	result := ByteArray new: size.
	LibC uniqueInstance ffiMemCopy: (anExternalAddress + (startIndex - 1)) to: result size: size.
	^ result
]

{ #category : #primitives }
GtPrimitiveExamples >> primitiveCopyFrom: src at: srcStart to: dest at: destStart size: size [
	<primitive: 'primitiveCopyFromAtToAtSize'>
	^ self primitiveFailed
]

{ #category : #tests }
GtPrimitiveExamples >> testByteArrayToExternalAddressBadArguments [
	<gtExample>
	| ea ba null |

	ea := ExternalAddress allocate: 8.
	ba := ByteArray new: 8.
	"Source isn't a ByteArray"
	self should:
		[ self
			primitiveCopyFrom: Object new
			at: 1
			to: ea
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Null address isn't allowed"
	null := ByteArray new: 8.
	ExternalAddress adoptInstance: null.
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1
			to: null
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Destination isn't a ExternalAddress"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1
			to: Object new
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Size isn't an integer"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1
			to: ea
			at: 1
			size: 8.3 ]
		raise: PrimitiveFailed.

	"Size must be >= 0"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1
			to: ea
			at: 1
			size: -1 ]
		raise: PrimitiveFailed.

	"start isn't an integer"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1.2
			to: ea
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"start must be >= 1"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 0
			to: ea
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"ByteArray buffer overflow from starting position"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 10
			to: ea
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"ByteArray buffer overflow from size"
	self should:
		[ self
			primitiveCopyFrom: ba
			at: 1
			to: ea
			at: 1
			size: 80  ]
		raise: PrimitiveFailed.

	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testByteArrayToExternalStartingAt1 [
	<gtExample>
	| ea ba size result |
	size := 24.
	ba := ByteArray new: size.
	1 to: size do: [ :i | ba byteAt: i put: i \\ 256 ].
	ea := ExternalAddress allocate: size.
	result := self
			primitiveCopyFrom: ba
			at: 1
			to: ea
			at: 1
			size: size.
	self assert: result equals: size.
	self assert: (self eaCopy: ea from: 1 to: size) equals: ba.
	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testByteArrayToExternalStartingAt11 [
	<gtExample>
	| ea ba size result |
	size := 24.
	ba := ByteArray new: size.
	1 to: size do: [ :i | ba byteAt: i put: i \\ 256 ].
	ea := ExternalAddress allocate: size+10.
	result := self
			primitiveCopyFrom: ba
			at: 1
			to: ea
			at: 11
			size: size.
	self assert: result equals: size.
	self assert: (self eaCopy: ea from: 11 to: size+10) equals: ba.
	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testExternalAddressToByteArrayBadArguments [
	<gtExample>
	| ea ba null |

	ea := ExternalAddress allocate: 8.
	ba := ByteArray new: 8.
	"Source isn't an ExternalAddress"
	self should:
		[ self
			primitiveCopyFrom: Object new
			at: 1
			to: ba 
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Null address isn't allowed"
	null := ByteArray new: 8.
	ExternalAddress adoptInstance: null.
	self should:
		[ self
			primitiveCopyFrom: null
			at: 1
			to: ba 
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Destination isn't a ByteArray"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: Object new
			at: 1
			size: 8 ]
		raise: PrimitiveFailed.

	"Size isn't an integer"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 1
			size: 8.3 ]
		raise: PrimitiveFailed.

	"Size must be >= 0"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 1
			size: -1 ]
		raise: PrimitiveFailed.

	"start isn't an integer"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 1.2
			size: 8 ]
		raise: PrimitiveFailed.

	"start must be >= 1"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 0
			size: 8 ]
		raise: PrimitiveFailed.

	"ByteArray buffer overflow from starting position"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba 
			at: 10
			size: 8 ]
		raise: PrimitiveFailed.

	"ByteArray buffer overflow from size"
	self should:
		[ self
			primitiveCopyFrom: ea
			at: 1
			to: ba 
			at: 1
			size: 80 ]
		raise: PrimitiveFailed.

	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testExternalToByteArrayStartingAt1 [
	<gtExample>
	| ea ba size result |
	size := 24.
	ea := ExternalAddress allocate: size.
	1 to: size do: [ :i | ea byteAt: i put: i \\ 256 ].
	ba := ByteArray new: size.
	result := self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 1
			size: size.
	self assert: result equals: size.
	self assert: ba equals: (self eaCopy: ea from: 1 to: size).
	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testExternalToByteArrayStartingAt11 [
	<gtExample>
	| ea ba size result |
	size := 24.
	ea := ExternalAddress allocate: size.
	1 to: size do: [ :i | ea byteAt: i put: i \\ 256 ].
	ba := ByteArray new: size + 10.
	result := self
			primitiveCopyFrom: ea
			at: 1
			to: ba
			at: 11
			size: size.
	self assert: result equals: size.
	self assert: (ba copyFrom: 11 to: ba size) equals: (self eaCopy: ea from: 1 to: size).
	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testLibCByteStringToExternalDataAndBack [
	<gtExample>
	| string ed size result wsCopy |

	string := 'hello, world'.
	size := string byteSize.
	ed := ExternalData
		fromHandle: (ExternalAddress allocate: size)
		type: ExternalType string.
	result := LibC memCopy: string
			to: ed
			size: size.
	self assert: result equals: ed getHandle.
	wsCopy := ByteString new: string size.
	result := LibC
		memCopy: ed
		to: wsCopy
		size: size.
	self assert: result class equals: ExternalAddress.
	self assert: wsCopy equals: string.
	ed free.
	^ ed
]

{ #category : #tests }
GtPrimitiveExamples >> testReplaceByteArrayToExternalStartingAt11 [
	<gtExample>
	| ea ba size |
	size := 24.
	ea := ExternalAddress allocate: size+10.
	ba := ByteArray new: size.
	1 to: size do: [ :i | 
		ba byteAt: i put: i \\ 256.
		ea byteAt: i put: 0 ].
	ea
		replaceFrom: 3 
		to: 12
		with: ba
		startingAt: 10.
	self assert: (self eaCopy: ea from: 1 to: 2)
		equals: (ByteArray new: 2).
	self assert: (self eaCopy: ea from: 3 to: 12) 
		equals: (ba copyFrom: 10 to: 19).
	self assert: (self eaCopy: ea from: 20 to: size)
		equals: (ByteArray new: 5).
	ea free.
	^ ba
]

{ #category : #tests }
GtPrimitiveExamples >> testWideStringToExternalAddressAndBack [
	<gtExample>
	| ws ea size result wsCopy |

	ws := 'Řepy'.
	self assert: ws isWideString.
	size := ws byteSize.
	ea := ExternalAddress allocate: size.
	result := self
			primitiveCopyFrom: ws
			at: 1
			to: ea
			at: 1
			size: size.
	self assert: result equals: size.
	wsCopy := WideString new: ws size.
	result := self
		primitiveCopyFrom: ea
		at: 1
		to: wsCopy
		at: 1
		size: size.
	self assert: result equals: size.
	self assert: wsCopy equals: ws.
	ea free.
	^ ea
]

{ #category : #tests }
GtPrimitiveExamples >> testWideStringToExternalDataAndBack [
	<gtExample>
	| ws ed size result wsCopy |

	ws := 'Řepy'.
	self assert: ws isWideString.
	size := ws byteSize.
	ed := ExternalData
		fromHandle: (ExternalAddress allocate: size)
		type: ExternalType string.
	result := self
			primitiveCopyFrom: ws
			at: 1
			to: ed gtMemcpyAddress
			at: 1
			size: size.
	self assert: result equals: size.
	wsCopy := WideString new: ws size.
	result := self
		primitiveCopyFrom: ed gtMemcpyAddress
		at: 1
		to: wsCopy
		at: 1
		size: size.
	self assert: result equals: size.
	self assert: wsCopy equals: ws.
	ed free.
	^ ed
]
