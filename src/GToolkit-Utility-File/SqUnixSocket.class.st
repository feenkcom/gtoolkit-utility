Class {
	#name : #SqUnixSocket,
	#superclass : #SqSocket,
	#category : #'GToolkit-Utility-File'
}

{ #category : #'close on exec' }
SqUnixSocket >> closeOnExec [
	| flag |

	flag := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD".
	self assert: [ flag ~= -1 ]
		description: 'fcntl() failed'.
	^ flag = 1
]

{ #category : #'close on exec' }
SqUnixSocket >> closeOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver.
	The code follows a GNU manual recommendation [1].
	[1] https://www.gnu.org/software/libc/manual/html_node/Descriptor-Flags.html"
	| old status |

	old := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 1 "F_GETFD".
	self assert: [ old ~= -1 ]
		description: 'fcntl() failed'.

	status := LibC uniqueInstance
		fcntl: self fileDescriptor 
		_: 2 "F_SETFD"
		_: (old bitAt: 1 put: aBoolean asBit).
	self assert: [ status ~= -1 ]
		description: 'fcntl() failed'.
]
