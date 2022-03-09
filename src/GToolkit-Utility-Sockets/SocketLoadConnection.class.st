Class {
	#name : #SocketLoadConnection,
	#superclass : #SocketLoadObject,
	#instVars : [
		'socket',
		'listenProcess',
		'localPort',
		'remoteAddress',
		'server',
		'stream'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #'instance creation' }
SocketLoadConnection class >> server: aPharoLinkServer socket: aSocket [

	^ self new initializeServer: aPharoLinkServer socket: aSocket
]

{ #category : #initialization }
SocketLoadConnection >> initializeServer: aSocketLoadServer socket: aSocket [

	server := aSocketLoadServer.
	socket := aSocket.
	localPort := aSocket localPort.
	remoteAddress := aSocket remoteAddress printString, ':', aSocket remotePort asString.
	stream := SocketStream on: socket.
	"10 minute timeout to allow for debugging"
	stream timeout: 600.
	SocketLoadConnectedAnnouncement new
		connection: self;
		emit.
	self start.
]

{ #category : #accessing }
SocketLoadConnection >> localPort [

	^ localPort
]

{ #category : #private }
SocketLoadConnection >> readCycle [
	| sendDataLength receivedDataLengthString receivedDataLength buffer sendDataLengthString |

	receivedDataLengthString := stream next: 10.
	self assert: (receivedDataLengthString allSatisfy: [ :ch |
		ch isDigit or: [ ch = Character space ] ]).
	receivedDataLength := receivedDataLengthString asNumber.
	self assert: (receivedDataLength between: 11 and: 20011).
	buffer := stream next: receivedDataLength.
	SocketLoadPacketReceivedAnnouncement new
		connection: self;
		packetSize: buffer size;
		emit.

	sendDataLengthString := buffer copyFrom: 1 to: 10.
	self assert: (sendDataLengthString allSatisfy: [ :ch |
		ch isDigit or: [ ch = Character space ] ]).
	sendDataLength := sendDataLengthString asNumber.
	self assert: (sendDataLength between: 1 and: 20000).

	buffer := String streamContents: [ :stringStream |
		stringStream
			<< (sendDataLength asString padRightTo: 10);
			<< (String loremIpsum: sendDataLength) ].
	stream nextPutAll: buffer.
	stream flush.
	SocketLoadPacketSentAnnouncement new
		connection: self;
		packetSize: sendDataLength;
		emit.

]

{ #category : #private }
SocketLoadConnection >> readCycleSafely [

	[ self readCycle ]
		on: Error 
		do: [ :ex |
			socket isConnected ifFalse:
				[ StringSignal emit: ex printString.
				SocketLoadDisconnectedAnnouncement new
					connection: self;
					emit ].
			^ false. ].
	^ true.
]

{ #category : #accessing }
SocketLoadConnection >> remoteAddress [

	^ remoteAddress
]

{ #category : #private }
SocketLoadConnection >> start [

	listenProcess :=
		[ [ self readCycleSafely ] whileTrue ]
			forkAt: Processor userSchedulingPriority
			named: 'SocketLoadConnection listenProcess'.
]
