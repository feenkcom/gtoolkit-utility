Extension { #name : #LibC }

{ #category : #'*GToolkit-Utility-File' }
LibC >> fcntl: fileDescriptor _: cmd [
	"Perform the specified fcntl command.
	Note: fcntl is a variadic C function, which is not supported by ffi on arm64 architectures. To work around the issue, we provide it as a primitive instead."
	<primitive: 'primitiveFcntl'>
	
	^ self primitiveFailed
]

{ #category : #'*GToolkit-Utility-File' }
LibC >> fcntl: fileDescriptor _: cmd _: argument [
	"Perform the specified fcntl command.
	Note: fcntl is a variadic C function, which is not supported by ffi on arm64 architectures. To work around the issue, we provide it as a primitive instead."
	<primitive: 'primitiveFcntl'>
	
	^ self primitiveFailed
]

{ #category : #'*GToolkit-Utility-File' }
LibC >> fileno: fileStar [
	"Answer the file descriptor for the supplied FILE*."
	 
	 ^self ffiCall: #(int fileno(void* fileStar))
]
