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

		"On Windows: sockets are never transferred to subprocesses"
		OSPlatform current isWindows ifTrue: 
			[ "Setting shouldn't raise an exception"
			binaryStream closeOnExec: false.
			self assert: binaryStream closeOnExec.
			^ self ].
			
		originalValue := binaryStream closeOnExec.
		binaryStream closeOnExec: false.
		self deny: binaryStream closeOnExec.
		binaryStream closeOnExec: true.
		self assert: binaryStream closeOnExec.
		binaryStream closeOnExec: originalValue ].
]

{ #category : #examples }
FileDescriptorExamples >> socketCloseOnExecFlag [
	"Demonstrate reading and setting the CLOEXEC flag for a socket"
	<gtExample>
	<after: #closeSocket>

	self assert: socket isNil.
	socket := Socket tcpCreateIfFail: [ self error: 'Unable to create socket' ].

	"On Windows: sockets are never transferred to subprocesses"
	OSPlatform current isWindows ifTrue: 
		[ "Setting shouldn't raise an exception"
		socket closeOnExec: false.
		self assert: socket closeOnExec.
		^ self ].

	socket closeOnExec: false.
	self deny: socket closeOnExec.

	socket closeOnExec: true.
	self assert: socket closeOnExec.
]
