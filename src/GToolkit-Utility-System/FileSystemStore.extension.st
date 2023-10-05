Extension { #name : #FileSystemStore }

{ #category : #'*GToolkit-Utility-System' }
FileSystemStore >> osCopy: sourcePath ifAbsent: absentBlock to: destinationPath ifPresent: presentBlock fileSystem: aFilesystem [
	"Copy the source to the destination using the OS utilities.
	Evaluate the appropriate block if the source doesn't exist or the destination does."

	(self exists: sourcePath) ifFalse: [ ^ absentBlock value ].
	(self exists: destinationPath) ifTrue: 
		[ "cannot overwrite destination"
		^ presentBlock value ].

	self osCopy: sourcePath to: destinationPath
]

{ #category : #'*GToolkit-Utility-System' }
FileSystemStore >> osCopy: sourcePath to: destinationPath [
	"Copy the source to the destination using the OS utilities.
	Evaluate the appropriate block if the source doesn't exist or the destination does.
	FileSystemStores that support this should overwrite the method."

	self error: 'osCopy is not supported on ', self class name.
]
