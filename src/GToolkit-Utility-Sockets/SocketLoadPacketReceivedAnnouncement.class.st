Class {
	#name : #SocketLoadPacketReceivedAnnouncement,
	#superclass : #SocketLoadSignal,
	#instVars : [
		'packetSize'
	],
	#category : #'GToolkit-Utility-Sockets'
}

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
		print: packetSize.
]
