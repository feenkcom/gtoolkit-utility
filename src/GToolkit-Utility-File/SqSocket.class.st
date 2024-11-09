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

{ #category : #'close on exec' }
SqSocket >> closeOnExec [
	"Answer a boolean indicating whether the receiver will not be inherited by child processes"

	^ OSPlatform current isWindows
		ifTrue: [ self windowsCloseOnExec ]
		ifFalse: [ self unixCloseOnExec ]
]

{ #category : #'close on exec' }
SqSocket >> closeOnExec: aBoolean [
	"Set the receiver's flags so that the file descriptor isn't inherited by child processes"

	OSPlatform current isWindows
		ifTrue: [ self windowsCloseOnExec: aBoolean ]
		ifFalse: [ self unixCloseOnExec: aBoolean ]
]

{ #category : #accessing }
SqSocket >> fileDescriptor [
	"Answer the receiver's file descriptor"

	^ self privateSocketPtr s
]

{ #category : #'close on exec' }
SqSocket >> getHandleInformation: hObject mask: flagsOutPtr [

	^ self ffiCall: #(#uint #GetHandleInformation #(#int64 #hObject, uint32 * #flagsOutPtr)) module: 'Kernel32.dll'
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

{ #category : #initialization }
SqSocket >> setHandle: aHandle [

	self assert: [ aHandle isNotNil ]
		description: 'SqSocket requires an open socket handle'.
	^ super setHandle: aHandle.
]

{ #category : #'close on exec' }
SqSocket >> setHandleInformation: hObject mask: mask flags: flags [

	^ self ffiCall: #(#uint #SetHandleInformation #(#int64 #hObject, #int16 #mask, #int16 #flags)) module: 'Kernel32.dll'
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

{ #category : #'close on exec' }
SqSocket >> unixCloseOnExec [
	| flag |

	flag := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD".
	self assert: [ flag ~= -1 ]
		description: 'fcntl() failed'.
	^ flag = 1
]

{ #category : #'close on exec' }
SqSocket >> unixCloseOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver.
	The code follows a GNU manual recommendation [1].
	[1] https://www.gnu.org/software/libc/manual/html_node/Descriptor-Flags.html"
	| old status |

	old := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD".
	self assert: [ old ~= -1 ]
		description: 'fcntl() failed'.

	status := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 2 "F_SETFD"
		_: (old bitAt: 1 put: aBoolean asBit).
	self assert: [ status ~= -1 ]
		description: 'fcntl() failed'.
]

{ #category : #'close on exec' }
SqSocket >> windowsCloseOnExec [
	| flagsOutPtr result status |
	
	flagsOutPtr := ExternalAddress allocate: FFIUInt32 externalTypeSize.
	status := self getHandleInformation: self fileDescriptor mask: flagsOutPtr.
	status = 0 ifTrue: [ self error: 'Unable to get socket status' ].
	result := flagsOutPtr uint32AtOffset: 0.
	flagsOutPtr free.
	^ result = 0.
]

{ #category : #'close on exec' }
SqSocket >> windowsCloseOnExec: aBoolean [
	"Clear the HANDLE_FLAG_INHERIT flag on the receiver so that the file descriptor is not passed to child processes"
	| status |

	status := self setHandleInformation: self fileDescriptor
		mask: 1 "HANDLE_FLAG_INHERIT=1"
		flags: aBoolean not asBit.
	self assert: status ~= 0.
]
