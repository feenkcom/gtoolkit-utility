"
SqPrivateSocket is the C structure used by the Sqeak / Pharo VM to hold open socket details, and is referenced by {{gtClass:SqSocket}}.
"
Class {
	#name : #SqPrivateSocket,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_CONNSEMA',
		'OFFSET_READSEMA',
		'OFFSET_S',
		'OFFSET_SOCKETERROR',
		'OFFSET_SOCKETSTATE',
		'OFFSET_WRITESEMA'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #'field definition' }
SqPrivateSocket class >> fieldsDesc [ 
	"Retrieved from platforms/unix/plugins/SocketPlugin/sqUnixSocket.c 2022-02-05.
	WARNING: This is only the first 6 fields, not the complete description."
	"self rebuildFieldAccessors"

	^ #(
		int s
		int connSema
		int readSema
		int writeSema
		int socketState
		int socketError
	)
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> connSema [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_CONNSEMA
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> connSema: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_CONNSEMA put: anObject
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> readSema [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_READSEMA
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> readSema: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_READSEMA put: anObject
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> s [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_S
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> s: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_S put: anObject
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> socketError [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SOCKETERROR
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> socketError: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SOCKETERROR put: anObject
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> socketState [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SOCKETSTATE
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> socketState: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SOCKETSTATE put: anObject
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> writeSema [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_WRITESEMA
]

{ #category : #'accessing - structure variables' }
SqPrivateSocket >> writeSema: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_WRITESEMA put: anObject
]
