Extension { #name : #Socket }

{ #category : #'*GToolkit-Utility-File' }
Socket >> closeOnExec [
	"Answer a boolean indicating whether the CloseOnExec bit is set.
	Only valid after the socket has been opened."

	^ self sqSocket closeOnExec

]

{ #category : #'*GToolkit-Utility-File' }
Socket >> closeOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver.
	Must be called after the socket has been opened."

	self sqSocket closeOnExec: aBoolean

]

{ #category : #'*GToolkit-Utility-File' }
Socket class >> newTCP [
	"Create a socket and initialize it for TCP.
	Set the flags so the file descriptor is not inherited by child processes."
	| newSocket |

	self initializeNetwork.
	newSocket := [ super new initialize: TCPSocketType ] repeatWithGCIf: 
		[ :socket | socket isValid not ].
	newSocket closeOnExec: true.
	^ newSocket
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> sqSocket [

	^ SqSocket forPlatform fromHandle: socketHandle
]
