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

	result := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD".
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
	| status |

	status := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 2 "F_SETFD"
		_: (aBoolean ifTrue: [ 1 ] ifFalse: [ 0 ]).
	self assert: [ status ~= -1 ]
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
