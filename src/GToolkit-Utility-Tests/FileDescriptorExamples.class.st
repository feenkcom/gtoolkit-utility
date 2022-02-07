Class {
	#name : #FileDescriptorExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'socket'
	],
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #private }
FileDescriptorExamples >> closeSocket [

	socket ifNil: [ ^ self ].
	socket closeAndDestroy.
	socket := nil.
]

{ #category : #examples }
FileDescriptorExamples >> fileCloseOnExecFlag [
	"Demonstrate reading and setting the CLOEXEC flag for a file"
	<gtExample>
	| binaryStream originalValue |

	SourceFiles sourcesFileStream path asFileReference binaryReadStreamDo: [ :stream |
		binaryStream := stream.
		[ binaryStream wrappedStream ] whileNotNil:
			[ binaryStream := stream wrappedStream ].
		originalValue := binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: false.
		self deny: binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: true.
		self assert: binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: originalValue ].
]

{ #category : #examples }
FileDescriptorExamples >> socketCloseOnExecFlag [
	"Demonstrate reading and setting the CLOEXEC flag for a file"
	<gtExample>
	<after: #closeSocket>

	self assert: socket isNil.
	socket := Socket tcpCreateIfFail: [ self error: 'Unable to create socket' ].
	socket setCloseOnExec: false.
	self deny: socket getCloseOnExec.
	socket setCloseOnExec: true.
	self assert: socket getCloseOnExec.

]
