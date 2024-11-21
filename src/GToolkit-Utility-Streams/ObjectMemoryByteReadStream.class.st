"
ObjectMemoryByteReadStream provides a fast stream that returns bytes from variableByte and variableWord subclasses.

Note that this is different from `#byteAt:` for {{gtClass:WideString}}s, as WideString changes the endiness of the words.
"
Class {
	#name : #ObjectMemoryByteReadStream,
	#superclass : #ReadStream,
	#category : #'GToolkit-Utility-Streams'
}

{ #category : #accesssing }
ObjectMemoryByteReadStream >> next [
	"Answer the next byte in the Stream.
	Fail if the stream is positioned at its end, or if the position is out of
	bounds in the collection."

	^ (self next: 1) first
]

{ #category : #accessing }
ObjectMemoryByteReadStream >> next: anInteger [
	"Answer the next anInteger bytes of my collection.  Overriden for efficiency"
	| ans endPosition |

	endPosition := position + anInteger  min:  readLimit.
	ans := ByteArray new: endPosition - position.
	ByteArray primitiveCopyFrom: collection at: position+1 to: ans at: 1 size: ans size.
	position := endPosition.
	^ ans
]

{ #category : #initialization }
ObjectMemoryByteReadStream >> on: aCollection [

	aCollection ifNil: [ 
		^ Error signal: 'Streams cannot be initialized with a nil collection' ].
		
	collection := aCollection.
	readLimit := aCollection byteSize.
	self reset
]

{ #category : #'initialization ' }
ObjectMemoryByteReadStream >> on: aCollection from: firstIndex to: lastIndex [
	| len |

	collection := aCollection.
	readLimit :=  lastIndex > (len := collection byteSize)
						ifTrue: [len]
						ifFalse: [lastIndex].
	position := firstIndex <= 1
				ifTrue: [0]
				ifFalse: [firstIndex - 1]
]

{ #category : #accesssing }
ObjectMemoryByteReadStream >> readInto: aCollection startingAt: startIndex count: n [
	"Read n bytes into the given collection.
	Return number of elements that have been read."
	| max |

	max := (readLimit - position) min: n.
	ByteArray primitiveCopyFrom: collection
		at: position + 1
		to: aCollection
		at: startIndex
		size: max.
	position := position + max.
	^ max
]

{ #category : #accessing }
ObjectMemoryByteReadStream >> skipTo: anInteger [
	| end |

	end := position + 1.
	[ (collection byteAt: end) ~= anInteger and: [ end <= readLimit ] ] whileTrue:
		[ end := end + 1 ].
	^ end > readLimit
		ifTrue: [ self setToEnd. false ]
		ifFalse: [ position := end. true]
]

{ #category : #accessing }
ObjectMemoryByteReadStream >> upTo: anInteger [
	| start end |

	start := position+1.
	end := start.
	[ (collection byteAt: end) ~= anInteger and: [ end <= readLimit ] ] whileTrue:
		[ end := end + 1 ].
	"not present--return rest of the collection"
	end > readLimit ifTrue: [ ^self upToEnd ].

	"skip to the end and return the data passed over"
	^ self next: end - start.
]

{ #category : #accessing }
ObjectMemoryByteReadStream >> upToAnyOf: aCollection do: aBlock [
	"This follows the behaviour of ReadStream>>upToAnyOf:do:"
	| end result |
	end := collection indexOfAnyOf: aCollection startingAt: 1 + position ifAbsent: [0].
	(end = 0 or: [end > readLimit]) ifTrue: [ ^self upToEnd ].
	result := self next: end - position - 1.
	aBlock value: self next.
	^result
]

{ #category : #accessing }
ObjectMemoryByteReadStream >> upToEnd [

	^ self next: readLimit - position.
]
