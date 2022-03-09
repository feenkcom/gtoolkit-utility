Class {
	#name : #SocketLoadServer,
	#superclass : #SocketLoadObject,
	#instVars : [
		'socket',
		'listenProcess',
		'connections',
		'localPort'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #private }
SocketLoadServer class >> listenBacklogSize [
	"Server socket backlog size (number of pending connection waiting to be accepted)"
	
	^ 32
]

{ #category : #private }
SocketLoadServer class >> serverSocketOn: port [
	"Answer a configured socket listening on port"
	| socket |

	(socket := Socket newTCP)
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: self socketBufferSize;
		setOption: 'SO_RCVBUF' value: self socketBufferSize .
	socket listenOn: port backlogSize: self listenBacklogSize.
	socket isValid
		ifFalse: [ self error: 'Cannot create socket on port ', port printString ].
	^ socket
]

{ #category : #private }
SocketLoadServer class >> socketBufferSize [
	"Size in bytes for Sockets and SocketStream IO buffers"

	^ 4096
]

{ #category : #'as yet unclassified' }
SocketLoadServer class >> startWithLoggingOn: aPortNumber [
	| signals |

	signals := BeaconSignal excludingNormalOperationSignals
		addExclusion: PharoLinkEvalSignal;
		yourself.
	RestartingStreamLogger stdout startFor: signals.

	self new
		localPort: aPortNumber;
		start.
]

{ #category : #private }
SocketLoadServer >> addConnection: aSocketLoadConnection [

	connections add: aSocketLoadConnection.

]

{ #category : #initialization }
SocketLoadServer >> initialize [

	super initialize.
	connections := OrderedCollection new.
]

{ #category : #accessing }
SocketLoadServer >> localPort [

	^ localPort
]

{ #category : #accessing }
SocketLoadServer >> localPort: anObject [

	localPort := anObject
]

{ #category : #private }
SocketLoadServer >> newConnection: aSocket [

	^ SocketLoadConnection server: self socket: aSocket
]

{ #category : #accessing }
SocketLoadServer >> remoteAddress [

	^ '<none>'
]

{ #category : #'start-stop' }
SocketLoadServer >> start [

	self assert: localPort isNumber.

	socket := self class serverSocketOn: localPort.
	listenProcess := 
		[ | bindSocket |
	   [ [ bindSocket isNil ] whileTrue: 
			[ bindSocket := socket
				waitForAcceptFor: 10
				ifTimedOut: [ nil ] ].
	   self addConnection: (self newConnection: bindSocket).
	   bindSocket := nil ] repeat ]
			forkAt: Processor lowIOPriority
			named: 'SocketLoadServer listenProcess'

]
