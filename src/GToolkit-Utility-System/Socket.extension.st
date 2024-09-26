Extension { #name : #Socket }

{ #category : #'*GToolkit-Utility-System' }
Socket >> socketErrorMessage [
	| socketErrorCode |
	
	[ socketErrorCode := self socketError ]
		  on: Error
		  do: [ ^ 'SocketError: unable to retrieve code, connected: ',
		  	self isConnected printString ].
	^ [ OSPlatform current getErrorMessage: socketErrorCode ]
		  on: Error
		  do: [ 'SocketError: unable to retrieve message, code: ' , socketErrorCode printString ]
]
