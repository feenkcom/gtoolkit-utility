"
SqFile is the data structure used by the Squeak / Pharo VM to record open file information.
"
Class {
	#name : #SqFile,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_FILE',
		'OFFSET_ISSTDIOSTREAM',
		'OFFSET_LASTCHAR',
		'OFFSET_LASTOP',
		'OFFSET_SESSIONID',
		'OFFSET_WRITABLE'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #'field definition' }
SqFile class >> fieldsDesc [
	"Retrieved from extracted/plugins/FilePlugin/include/common/FilePlugin.h 2022-02-05"
	"self rebuildFieldAccessors"

	^ #(
		int 	sessionID
		void 	*file
		char	writable
		char 	lastOp
		char	lastChar
		char	isStdioStream
	)
]

{ #category : #'accessing - structure variables' }
SqFile >> file [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_FILE) type: ExternalType void asPointerType
]

{ #category : #'accessing - structure variables' }
SqFile >> file: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_FILE put: anObject getHandle.
]

{ #category : #accessing }
SqFile >> fileDescriptor [

	^ LibC uniqueInstance fileno: self file
]

{ #category : #'close on exec' }
SqFile >> getCloseOnExec [
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
SqFile >> isStdioStream [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_ISSTDIOSTREAM
]

{ #category : #'accessing - structure variables' }
SqFile >> isStdioStream: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_ISSTDIOSTREAM put: anObject
]

{ #category : #'accessing - structure variables' }
SqFile >> lastChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_LASTCHAR
]

{ #category : #'accessing - structure variables' }
SqFile >> lastChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_LASTCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
SqFile >> lastOp [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_LASTOP
]

{ #category : #'accessing - structure variables' }
SqFile >> lastOp: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_LASTOP put: anObject
]

{ #category : #'accessing - structure variables' }
SqFile >> sessionID [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SESSIONID
]

{ #category : #'accessing - structure variables' }
SqFile >> sessionID: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SESSIONID put: anObject
]

{ #category : #'close on exec' }
SqFile >> setCloseOnExec: aBoolean [
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
SqFile >> setHandle: aHandle [

	self assert: [ aHandle isNotNil ]
		description: 'SqFile requires an open file handle'.
	^ super setHandle: aHandle.
]

{ #category : #'accessing - structure variables' }
SqFile >> writable [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_WRITABLE
]

{ #category : #'accessing - structure variables' }
SqFile >> writable: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_WRITABLE put: anObject
]
