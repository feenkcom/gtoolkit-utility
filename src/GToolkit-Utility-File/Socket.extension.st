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

	self isValid ifFalse: [ ^ self ].
	self sqSocket closeOnExec: aBoolean
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> listenOn: port [
	"Listen for a connection on the given port. This operation will return immediately; follow it with waitForConnectionUntil: to wait until a connection is established."

	| status |
	status := self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].

	self primSocket: socketHandle listenOn: port.
	self closeOnExec: true.
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> listenOn: portNumber backlogSize: backlog [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status := self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog.
	self closeOnExec: true.
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status := self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog interface: ifAddr.
	self closeOnExec: true.
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> sqSocket [

	^ SqSocket fromHandle: socketHandle
]
