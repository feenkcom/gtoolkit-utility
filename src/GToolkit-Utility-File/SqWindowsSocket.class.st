Class {
	#name : #SqWindowsSocket,
	#superclass : #SqSocket,
	#category : #'GToolkit-Utility-File'
}

{ #category : #'close on exec' }
SqWindowsSocket >> closeOnExec [
	| flagsOutPtr result |
	
	flagsOutPtr := ExternalAddress allocate: FFIUInt32 externalTypeSize.
	self getHandleInformation: self fileDescriptor mask: flagsOutPtr.
	result := flagsOutPtr uint32AtOffset: 0.
	flagsOutPtr free.
	^ result = 0.
]

{ #category : #'close on exec' }
SqWindowsSocket >> closeOnExec: aBoolean [
	"Clear the HANDLE_FLAG_INHERIT flag on the receiver so that the file descriptor is not passed to child processes"
	| status |

	status := self setHandleInformation: self fileDescriptor
		mask: 1 "HANDLE_FLAG_INHERIT=1"
		flags: 0.
	self assert: status ~= 0.
]

{ #category : #'close on exec' }
SqWindowsSocket >> getHandleInformation: hObject mask: flagsOutPtr [

	^ self ffiCall: #(#uint #GetHandleInformation #(#int64 #hObject, uint32 * #flagsOutPtr)) module: 'Kernel32.dll'
]

{ #category : #'close on exec' }
SqWindowsSocket >> setHandleInformation: hObject mask: mask flags: flags [

	^ self ffiCall: #(#uint #SetHandleInformation #(#int64 #hObject, #int16 #mask, #int16 #flags)) module: 'Kernel32.dll'
]
