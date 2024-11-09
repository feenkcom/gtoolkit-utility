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
Socket >> sqSocket [

	^ SqSocket forPlatform fromHandle: socketHandle
]

{ #category : #'*GToolkit-Utility-File' }
Socket >> waitForConnectionFor: timeout ifTimedOut: timeoutBlock [
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."

	| startTime msecsDelta msecsEllapsed status |
	startTime := Time millisecondClockValue.
	msecsDelta := (timeout * 1000) truncated.
	status := self primSocketConnectionStatus: socketHandle.
	[(status = WaitingForConnection) and: [(msecsEllapsed := Time millisecondsSince: startTime) < msecsDelta]]
		whileTrue: [
			semaphore waitTimeoutMSecs: msecsDelta - msecsEllapsed.
			status := self primSocketConnectionStatus: socketHandle].
	self closeOnExec: true.
	status = Connected ifFalse: [^timeoutBlock value].
	^ true
]
