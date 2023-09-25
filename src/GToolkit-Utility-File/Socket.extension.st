Extension { #name : #Socket }

{ #category : #'*GToolkit-Utility-File' }
Socket >> getCloseOnExec [
	"Answer a boolean indicating whether the CloseOnExec bit is set.
	Only valid after the socket has been opened."

	^ self sqSocket getCloseOnExec

]

{ #category : #'*GToolkit-Utility-File' }
Socket >> setCloseOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver.
	Must be called after the socket has been opened."

	self sqSocket setCloseOnExec: aBoolean

]

{ #category : #'*GToolkit-Utility-File' }
Socket >> sqSocket [

	^ SqSocket fromHandle: socketHandle
]
