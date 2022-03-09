Class {
	#name : #SocketLoadPacketSentAnnouncement,
	#superclass : #SocketLoadSignal,
	#instVars : [
		'packetSize'
	],
	#category : #'GToolkit-Utility-Sockets'
}

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
		print: packetSize.
]
