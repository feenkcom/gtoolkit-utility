Extension { #name : #LibC }

{ #category : #'*GToolkit-Utility-File' }
LibC >> fcntl: fileDescriptor _: cmd [
	"Perform the specified fcntl command"
	 
	 ^self ffiCall: #(int fcntl(int fileDescriptor, int cmd))
]

{ #category : #'*GToolkit-Utility-File' }
LibC >> fcntl: fileDescriptor _: cmd _: argument [
	"Perform the specified fcntl command"
	 
	 ^self ffiCall: #(int fcntl(int fileDescriptor, int cmd, int argument))
]

{ #category : #'*GToolkit-Utility-File' }
LibC >> fileno: fileStar [
	"Answer the file descriptor for the supplied FILE*."
	 
	 ^self ffiCall: #(int fileno(void* fileStar))
]
