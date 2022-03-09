Class {
	#name : #SocketLoadPacketSentAnnouncement,
	#superclass : #SocketLoadSignal,
	#instVars : [
		'packetSize',
		'packetCount'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #accessing }
SocketLoadPacketSentAnnouncement >> packetCount [

	^ packetCount
]

{ #category : #accessing }
SocketLoadPacketSentAnnouncement >> packetCount: anObject [

	packetCount := anObject
]

{ #category : #accessing }
SocketLoadPacketSentAnnouncement >> packetSize [

	^ packetSize
]

{ #category : #accessing }
SocketLoadPacketSentAnnouncement >> packetSize: anObject [

	packetSize := anObject
]

{ #category : #printing }
SocketLoadPacketSentAnnouncement >> printOneLineContentsOn: aStream [

	super printOneLineContentsOn: aStream.
	aStream
		<< ' sent: ';
		print: packetSize;
		<< ' count: ';
		print: packetCount.
]
