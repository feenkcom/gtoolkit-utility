Class {
	#name : #GtWindowsSocketReadWorkaroundSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'socket',
		'operation'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #'instance creation' }
GtWindowsSocketReadWorkaroundSignal class >> emitSocket: aSocket operation: aString [

	self new
		socket: aSocket;
		operation: aString;
		emit.
]

{ #category : #accessing }
GtWindowsSocketReadWorkaroundSignal >> operation [

	^ operation
]

{ #category : #accessing }
GtWindowsSocketReadWorkaroundSignal >> operation: anObject [

	operation := anObject
]

{ #category : #printing }
GtWindowsSocketReadWorkaroundSignal >> printOneLineContentsOn: aStream [

	socket
		ifNil: [ aStream << '<none>' ]
		ifNotNil: [ socket socketHandle printHexOn: aStream ].
	aStream
		<< ': ';
		<< operation asString.
]

{ #category : #accessing }
GtWindowsSocketReadWorkaroundSignal >> socket [

	^ socket
]

{ #category : #accessing }
GtWindowsSocketReadWorkaroundSignal >> socket: anObject [

	socket := anObject
]
