"
GtWindowsSocketReadMonitor monitors Sockets and logs, and optionally signals, the read semaphore of the socket if it appears that there is data available, but the semaphore hasn't been signalled.

It was originally developed as part of tracking down issues with sockets in Gt / Pharo 9 in March 2022.

Usage:

```
readMonitor := GtWindowsSocketReadMonitor new 
	""Leave setLogOnly out to try signalling the semaphore""
	setLogOnly;
	start.
```

"
Class {
	#name : #GtWindowsSocketReadMonitor,
	#superclass : #Object,
	#instVars : [
		'process',
		'sockets',
		'shutdownFlag',
		'logOnly'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #private }
GtWindowsSocketReadMonitor >> checkAllSockets [

	Socket allInstancesDo: [ :socket |
		[ self checkSocket: socket ]
			on: Error
			do: [ :ex | ex asBeaconSignal emit ] ].
	10 seconds wait.
]

{ #category : #private }
GtWindowsSocketReadMonitor >> checkAllSocketsSafely [

	[ self checkAllSockets ]
		on: Error
		do: [ :ex | 
			ex asBeaconSignal emit.
			10 seconds wait. ]
]

{ #category : #'private - state' }
GtWindowsSocketReadMonitor >> checkForData: socket [

	socket socketHandle ifNil: [ ^ self ].

	(socket isValid and: 
	[ socket isWaitingForConnection not and:
	[ socket dataAvailable ]]) ifFalse: [ ^ self ].

	1 second wait.
	socket dataAvailable ifFalse: [ ^ self ].
	logOnly ifTrue:
		[ GtWindowsSocketReadWorkaroundSignal emitSocket: socket operation: #dataAvailable.
		^ self ].
	GtWindowsSocketReadWorkaroundSignal emitSocket: socket operation: #signalled.
	socket readSemaphore signal.
]

{ #category : #private }
GtWindowsSocketReadMonitor >> checkSocket: socket [
	| socketStatus |

	socket socketHandle ifNil: [ ^ self ].
	socketStatus := sockets at: socket ifAbsentPut: [ #firstCheck: ].
	self perform: socketStatus with: socket.
]

{ #category : #'private - state' }
GtWindowsSocketReadMonitor >> firstCheck: socket [
	"Do nothing the first time"

	sockets at: socket put: #secondCheck:.
]

{ #category : #initialization }
GtWindowsSocketReadMonitor >> initialize [

	super initialize.
	shutdownFlag := false.
	sockets := Dictionary new.
	logOnly := false.
]

{ #category : #'private - state' }
GtWindowsSocketReadMonitor >> secondCheck: socket [
	"Do nothing one more time"

	sockets at: socket put: #checkForData:.
]

{ #category : #initialization }
GtWindowsSocketReadMonitor >> setLogOnly [

	logOnly := true.
]

{ #category : #'start-stop' }
GtWindowsSocketReadMonitor >> start [
	"Start the read monitor.
	Valid only on Windows."

	OSPlatform currentPlatformName = #Win32 ifFalse: [ ^ self ].

	process ifNotNil:
		[ self error: 'Monitor process already started' ].
	process := [ [ self checkAllSocketsSafely ] repeat ]
		forkAt: Processor lowIOPriority
		named: 'Windows Socket read monitor'.
]
