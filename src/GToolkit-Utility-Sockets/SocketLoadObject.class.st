Class {
	#name : #SocketLoadObject,
	#superclass : #Object,
	#instVars : [
		'socket'
	],
	#category : #'GToolkit-Utility-Sockets'
}

{ #category : #private }
SocketLoadObject >> numberFrom: aString [
	| number |

	aString ifEmpty:
		"The socket may have been closed"
		[ socket isConnected ifFalse: 
			[ self error: 'Socket closed' ] ].
	self assert: aString size = 10
		description: 'number string size = ', aString size asString.
	self assert: (aString allSatisfy: [ :ch | ch isDigit or: [ ch = Character space ] ])
		description: 'aString isn''t digits: ', aString printString.
	number := [ aString asNumber ]
		on: Error 
		do: [ :ex |
			StringSignal emit: 'Failed to convert number: ', aString printString.
			StringSignal emit: 'Still connected: ', socket isConnected printString.
			ex pass ].
	^ number
]
