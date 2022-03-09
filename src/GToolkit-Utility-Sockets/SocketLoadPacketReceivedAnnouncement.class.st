Class {
	#name : #SocketLoadPacketReceivedAnnouncement,
	#superclass : #SocketLoadSignal,
	#instVars : [
		'packetSize',
		'packetCount'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #accessing }
SocketLoadPacketReceivedAnnouncement >> packetCount [

	^ packetCount
]

{ #category : #accessing }
SocketLoadPacketReceivedAnnouncement >> packetCount: anObject [

	packetCount := anObject
]

{ #category : #accessing }
SocketLoadPacketReceivedAnnouncement >> packetSize [

	^ packetSize
]

{ #category : #accessing }
SocketLoadPacketReceivedAnnouncement >> packetSize: anObject [

	packetSize := anObject
]

{ #category : #printing }
SocketLoadPacketReceivedAnnouncement >> printOneLineContentsOn: aStream [

	super printOneLineContentsOn: aStream.
	aStream
		<< ' received: ';
		print: packetSize;
		<< ' count: ';
		print: packetCount.
]
