Extension { #name : #FileSystem }

{ #category : #'*GToolkit-Utility-System' }
FileSystem >> osCopy: sourcePath ifAbsent: absentBlock to: destinationPath ifPresent: presentBlock [
	"Copy the file referenced as sourcePath to the destination referred as destPath. Perform associate actions in case of problems."

	store
		osCopy: (self resolve: sourcePath)
		ifAbsent: absentBlock
		to: (self resolve: destinationPath)
		ifPresent: presentBlock
		fileSystem: self
]

{ #category : #'*GToolkit-Utility-System' }
FileSystem >> osCopy: sourcePath to: destPath [
	"Copy the file referenced as sourcePath to the destination referred as destPath using the OS utilities.
	If there is no file at sourcePath, raise FileDoesNotExist.
	If destPath is a file, raise FileExists."
	
	self
		osCopy: sourcePath
		ifAbsent: [ store signalFileDoesNotExist: sourcePath ]
		to: destPath
		ifPresent: [ store signalFileExists: destPath ]
]

{ #category : #'*GToolkit-Utility-System' }
FileSystem >> osCopy: aPath toReference: destinationReference [

	^self = destinationReference fileSystem
		ifTrue: [ self osCopy: aPath to: destinationReference resolve path ]
		ifFalse: [ self error: 'OS file copy source and destination must have the same file system' ]
]
