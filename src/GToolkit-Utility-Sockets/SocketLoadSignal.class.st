Class {
	#name : #SocketLoadSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'connection'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #accessing }
SocketLoadSignal >> connection [

	^ connection
]

{ #category : #accessing }
SocketLoadSignal >> connection: anObject [

	connection := anObject
]

{ #category : #printing }
SocketLoadSignal >> printOneLineContentsOn: aStream [

	connection ifNil: [ ^ self ].
	aStream
		print: connection localPort;
		<< ' -> ';
		print: connection remoteAddress.
]
