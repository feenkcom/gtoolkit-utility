Class {
	#name : #SocketLoadClient,
	#superclass : #SocketLoadObject,
	#instVars : [
		'stream',
		'localPort',
		'remoteAddress',
		'process',
		'loopCount',
		'loopIndex'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #'instance creation' }
SocketLoadClient class >> startOnRemoteAddress: aString [

	^ self new
		remoteAddress: aString;
		start
]

{ #category : #'start-stop' }
SocketLoadClient >> connectToServer [

	socket := Socket newTCP.
	socket
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: 4096;
		setOption: 'SO_RCVBUF' value: 4096.
	socket connectToHostNamed: self hostname port: self port.
	socket isConnected ifFalse:
		[ self error: 'Unable to connect to server' ].
	localPort := socket localPort.
	stream := SocketStream on: socket.
	"10 minute timeout to allow for debugging"
	stream timeout: 600.
	SocketLoadConnectedAnnouncement new
		connection: self;
		emit.

]

{ #category : #private }
SocketLoadClient >> hostname [
	| index |

	index := remoteAddress indexOf: $:.
	^ index > 0
		ifTrue: [ remoteAddress copyFrom: 1 to: index -1 ]
		ifFalse: [ 'localhost' ]
]

{ #category : #initialization }
SocketLoadClient >> initialize [

	super initialize.
	loopCount := 10000.
	loopIndex := 0.
]

{ #category : #accessing }
SocketLoadClient >> localPort [

	^ localPort
]

{ #category : #accessing }
SocketLoadClient >> loopCount [

	^ loopCount
]

{ #category : #accessing }
SocketLoadClient >> loopCount: anObject [

	loopCount := anObject
]

{ #category : #private }
SocketLoadClient >> port [
	| index port |

	index := remoteAddress indexOf: $:.
	port := (index > 0
		ifTrue: [ remoteAddress copyFrom: index + 1 to: remoteAddress size ]
		ifFalse: [ remoteAddress ]) asNumber.
	self assert: (port between: 1 and: 2 ** 16).
	^ port.
]

{ #category : #accessing }
SocketLoadClient >> remoteAddress [

	^ remoteAddress
]

{ #category : #accessing }
SocketLoadClient >> remoteAddress: aString [

	remoteAddress := aString
]

{ #category : #'start-stop' }
SocketLoadClient >> runLoop [

	loopCount timesRepeat: 
		[ self sendReceiveCycle.
		(1 to: 100) atRandom milliSeconds wait ].
]

{ #category : #private }
SocketLoadClient >> sendReceiveCycle [
	| sendDataLength receiveDataLength receivedDataLengthString receivedDataLength buffer |

	loopIndex := loopIndex + 1.
	sendDataLength := (1 to: 20000) atRandom.
	receiveDataLength := (1 to: 20000) atRandom.
	buffer := String streamContents: [ :stringStream |
		stringStream
			<< ((sendDataLength + 10) asString padRightTo: 10);
			<< (receiveDataLength asString padRightTo: 10);
			<< (String loremIpsum: sendDataLength) ].
	stream nextPutAll: buffer.
	stream flush.
	SocketLoadPacketSentAnnouncement new
		connection: self;
		packetSize: sendDataLength;
		packetCount: loopIndex;
		emit.

	receivedDataLengthString := stream next: 10.
	SocketLoadPacketReceivedAnnouncement new
		connection: self;
		packetSize: receivedDataLengthString size;
		packetCount: loopIndex;
		emit.
	receivedDataLength := self numberFrom: receivedDataLengthString.
	self assert: (receivedDataLength between: 1 and: 20000).

	buffer := stream next: receivedDataLength.
	SocketLoadPacketReceivedAnnouncement new
		connection: self;
		packetSize: buffer size;
		packetCount: loopIndex;
		emit.
]

{ #category : #'start-stop' }
SocketLoadClient >> start [

	self connectToServer.
	self startLoop.
]

{ #category : #'start-stop' }
SocketLoadClient >> startAndWait [

	self connectToServer.
	self runLoop.
]

{ #category : #'start-stop' }
SocketLoadClient >> startLoop [

	process := [ self runLoop ]
		forkAt: Processor userSchedulingPriority 
		named: 'SocketLoadClient process'.
]
