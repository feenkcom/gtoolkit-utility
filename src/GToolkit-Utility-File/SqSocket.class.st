"
SqSocket is the C structure stored as the handle in an open {{gtClass:Socket}}.
"
Class {
	#name : #SqSocket,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_PRIVATESOCKETPTR',
		'OFFSET_SESSIONID',
		'OFFSET_SOCKETTYPE'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
SqSocket class >> fieldsDesc [
	"Retrieved from plugins/SocketPlugin/include/common/SocketPlugin.h 2022-02-05"
	"self rebuildFieldAccessors"

	^ #(
		int sessionID
		int socketType
		SqPrivateSocket *privateSocketPtr
		)
]

{ #category : #accessing }
SqSocket >> fileDescriptor [
	"Answer the receiver's file descriptor"

	^ self privateSocketPtr s
]

{ #category : #'close on exec' }
SqSocket >> getCloseOnExec [
	"Get the CLOEXEC bit for the receiver"
	| result |

	"Windows doesn't transfer open file descriptors"
	OSPlatform current isWindows ifTrue: [ ^ true ].

	result := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD"
		_: 0.
	self assert: [ result ~= -1 ]
		description: 'Unable to retrieve CLOEXEC'.
	^ (result bitAnd: 1) = 1
]

{ #category : #'accessing - structure variables' }
SqSocket >> privateSocketPtr [
	"This method was automatically generated"
	^SqPrivateSocket fromHandle: (handle pointerAt: OFFSET_PRIVATESOCKETPTR)
]

{ #category : #'accessing - structure variables' }
SqSocket >> privateSocketPtr: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PRIVATESOCKETPTR put: anObject getHandle.
]

{ #category : #'accessing - structure variables' }
SqSocket >> sessionID [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SESSIONID
]

{ #category : #'accessing - structure variables' }
SqSocket >> sessionID: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SESSIONID put: anObject
]

{ #category : #'close on exec' }
SqSocket >> setCloseOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver"
	| old status |

	"Ignore on Windows: sockets aren't transferred to subprocesses"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	old := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD"
		_: 0.
	self assert: [ old >= 0 ]
		description: 'fcntl() failed'.

	status := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 2 "F_SETFD"
		_: (old bitAt: 1 put: aBoolean asBit).
	self assert: [ status >= 0 ]
		description: 'fcntl() failed'.
]

{ #category : #initialization }
SqSocket >> setHandle: aHandle [

	self assert: [ aHandle isNotNil ]
		description: 'SqSocket requires an open socket handle'.
	^ super setHandle: aHandle.
]

{ #category : #'accessing - structure variables' }
SqSocket >> socketType [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SOCKETTYPE
]

{ #category : #'accessing - structure variables' }
SqSocket >> socketType: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SOCKETTYPE put: anObject
]
