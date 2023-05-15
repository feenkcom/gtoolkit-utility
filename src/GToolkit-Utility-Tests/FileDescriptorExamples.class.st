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
			binaryStream setCloseOnExec: false.
			self assert: binaryStream getCloseOnExec.
			^ self ].
			
		originalValue := binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: false.
		self deny: binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: true.
		self assert: binaryStream getCloseOnExec.
		binaryStream setCloseOnExec: originalValue ].
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
		socket setCloseOnExec: false.
		self assert: socket getCloseOnExec.
		^ self ].

	socket setCloseOnExec: false.
	self deny: socket getCloseOnExec.

	socket setCloseOnExec: true.
	self assert: socket getCloseOnExec.
]
