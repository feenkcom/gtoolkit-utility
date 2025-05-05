Class {
	#name : #ObjectMemoryByteReadStreamExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-Streams'
}

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArrayContents [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| byteArray |
	byteArray := #[1 2 3 4 5].
	self
		assert: (ObjectMemoryByteReadStream on: byteArray) upToEnd
		equals: byteArray
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArrayNext_number [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| stream |
	stream := ObjectMemoryByteReadStream on: #[1 2 3 4 5 6 7 8].
	self assert: (stream next: 3) equals: #[1 2 3].
	self assert: (stream next: 2) equals: #[4 5].
	self deny: stream atEnd.
	self assert: (stream next: 10) equals: #[6 7 8].
	self assert: stream atEnd
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArraySkipTo [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| stream |
	stream := ObjectMemoryByteReadStream on: #[1 2 3 4 5 6 7 8].
	stream skipTo: 3.
	self assert: stream next equals: 4.
	self deny: stream atEnd
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArraySkip_number [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| stream |
	stream := ObjectMemoryByteReadStream on: #[1 2 3 4 5 6 7 8].
	stream skip: 3.
	self assert: (stream next: 2) equals: #[4 5].
	self deny: stream atEnd.
	self assert: (stream next: 10) equals: #[6 7 8].
	self assert: stream atEnd
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArrayUpTo [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| stream |
	stream := ObjectMemoryByteReadStream on: #[1 2 3 4 5 6 7 8].
	self assert: (stream upTo: 3) equals: #[1 2].
	self deny: stream atEnd
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteArrayUpToAnyOfDo [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| stream result |
	stream := ObjectMemoryByteReadStream on: #[1 2 3 4 5 6 7 8].
	result := stream upToAnyOf: #(6 4) do: [ :i | self assert: i equals: 4 ].
	self assert: result equals: #[1 2 3].
	self assert: stream upToEnd equals: #[5 6 7 8].
	self assert: stream atEnd
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> byteStringContents [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| byteString |
	byteString := '12345'.
	self
		assert: (ObjectMemoryByteReadStream on: byteString) upToEnd
		equals: byteString asByteArray
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> wideStringContents [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| wideString |
	wideString := '123řž'.
	self
		assert: (ObjectMemoryByteReadStream on: wideString) upToEnd
		equals: #[49 0 0 0 50 0 0 0 51 0 0 0 89 1 0 0 126 1 0 0]
]

{ #category : #examples }
ObjectMemoryByteReadStreamExamples >> wideStringNext [
	<gtExample>
	<return: #ObjectMemoryByteReadStreamExamples>
	| wideString rStream byteArray |
	wideString := '123řž'.
	rStream := ObjectMemoryByteReadStream on: wideString.
	byteArray := ByteArray
			streamContents: [ :s | [ rStream atEnd ] whileFalse: [ s nextPut: rStream next ] ].
	self assert: byteArray equals: #[49 0 0 0 50 0 0 0 51 0 0 0 89 1 0 0 126 1 0 0]
]
