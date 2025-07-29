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

	self 
		forPharo12: [
			self
				bindToPort: port;
				listen.
			self closeOnExec: true.] 
		forPharo11AndPharo10: [
	
			| status |
			status := self primSocketConnectionStatus: socketHandle.
			(status == Unconnected)
				ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].

			self primSocket: socketHandle listenOn: port.
			self closeOnExec: true.]
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> listenOn: portNumber backlogSize: backlog [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	
	self 
		forPharo12: [
			self
				bindToPort: portNumber ;
				listenWithBacklog: backlog.
			self closeOnExec: true.] 
		forPharo11AndPharo10: [
			| status |
			status := self primSocketConnectionStatus: socketHandle.
			(status == Unconnected)
				ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
			self primSocket: socketHandle listenOn: portNumber backlogSize: backlog.
			self closeOnExec: true.]
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	
	self 
		forPharo12: [
			self
				bindTo: ifAddr port: portNumber;
				listenWithBacklog: backlog.
			self closeOnExec: true. ] 
		forPharo11AndPharo10: [
				| status |
				status := self primSocketConnectionStatus: socketHandle.
				(status == Unconnected)
					ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
					self primSocket: socketHandle listenOn: portNumber backlogSize: backlog interface: ifAddr.
				self closeOnExec: true.]
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> sqSocket [

	^ SqSocket fromHandle: socketHandle
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> waitForConnectionFor: timeout ifClosed: closedBlock ifTimedOut: timeoutBlock [
	"Wait up until the given deadline for a connection to be established.
	Evaluate closedBlock if the connection is closed locally,
	or timeoutBlock if the deadline expires.
	
	We should separately detect the case of a connection being refused here as well."
	<gtPharoPatch: #Pharo12>
	| startTime msecsDelta msecsElapsed status |

	self forPharo12: [] forPharo11AndPharo10: 
		[ self error: 'Not supported in Pharo11 and earlier' ].

	self closeOnExec: true.
	startTime := Time millisecondClockValue.
	msecsDelta := (timeout * 1000) truncated.

	[
	status := self primSocketConnectionStatus: socketHandle.
	status == WaitingForConnection and: [
		(msecsElapsed := Time millisecondsSince: startTime) < msecsDelta ] ]
		whileTrue: [ semaphore waitTimeoutMilliseconds: msecsDelta - msecsElapsed ].

	status == WaitingForConnection ifTrue: [ ^ timeoutBlock value ].
	status == Connected ifFalse: [ ^ closedBlock value ]
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> waitForConnectionFor: timeout ifTimedOut: timeoutBlock [
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."
	| startTime msecsDelta msecsEllapsed status |

	self closeOnExec: true.
	startTime := Time millisecondClockValue.
	msecsDelta := (timeout * 1000) truncated.
	status := self primSocketConnectionStatus: socketHandle.
	[(status = WaitingForConnection) and: [(msecsEllapsed := Time millisecondsSince: startTime) < msecsDelta]]
		whileTrue: [
			semaphore waitTimeoutMSecs: msecsDelta - msecsEllapsed.
			status := self primSocketConnectionStatus: socketHandle].
	status = Connected ifFalse: [^timeoutBlock value].
	^ true
]
