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

{ #category : #'instance creation' }
SqSocket class >> forPlatform [

	^ OSPlatform current isWindows 
		ifTrue: [ SqWindowsSocket ]
		ifFalse: [ SqUnixSocket ].
]

{ #category : #'close on exec' }
SqSocket >> closeOnExec [
	"Answer a boolean indicating whether the receiver will not be inherited by child processes"

	^ self subclassResponsibility
]

{ #category : #'close on exec' }
SqSocket >> closeOnExec: aBoolean [
	"Set the receiver's flags so that the file descriptor isn't inherited by child processes"

	self subclassResponsibility
]

{ #category : #accessing }
SqSocket >> fileDescriptor [
	"Answer the receiver's file descriptor"

	^ self privateSocketPtr s
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
