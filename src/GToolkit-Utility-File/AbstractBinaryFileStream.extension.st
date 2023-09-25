Extension { #name : #AbstractBinaryFileStream }

{ #category : #'*GToolkit-Utility-File' }
AbstractBinaryFileStream >> getCloseOnExec [
	"Answer a boolean indicating whether the CloseOnExec bit is set.
	Only valid while the file is open."

	^ self sqFile getCloseOnExec

]

{ #category : #'*GToolkit-Utility-File' }
AbstractBinaryFileStream >> setCloseOnExec: aBoolean [
	"Set/Clear the CLOEXEC bit on the receiver.
	Must be called while the file is open."

	self sqFile setCloseOnExec: aBoolean

]

{ #category : #'*GToolkit-Utility-File' }
AbstractBinaryFileStream >> sqFile [

	^ SqFile fromHandle: handle
]

{ #category : #'*GToolkit-Utility-File' }
AbstractBinaryFileStream >> wrappedStream [
	"Answer the stream that the receiver wraps.
	Since this the base stream, answer nil"

	^ nil
]
