Extension { #name : #FileReference }

{ #category : #'*GToolkit-Utility-File' }
FileReference >> canonicalize [
	<gtPharoPatch: #Pharo12>
	"Answer the receiver with references to the current folder (.) and parent folder (..) removed"

	^ self withPath: (self path canonicalizeOnFilesystem: filesystem)
]

{ #category : #'*GToolkit-Utility-File' }
FileReference class >> gtNewTempFileLocatorPrefix: prefix suffix: suffix [
	| tmpDir random fileName |
	
	tmpDir := FileLocator temp .
	[ 
		random := UUID new asInteger asString.
		fileName := prefix , random , suffix.
		(tmpDir / fileName) exists ] whileTrue.
	^ tmpDir / fileName
]

{ #category : #'*GToolkit-Utility-File' }
FileReference >> isFileReference [

	^ true
]

{ #category : #'*GToolkit-Utility-File' }
FileReference >> targetFileReference [
	"Return the target file of the File described by aPath.  For a regular file, this is itself, for a symbolic link, it is the file pointed to by the symbolic link"
	<gtPharoPatch: #Pharo12>

	^ self class fileSystem: filesystem path: self symlinkEntry targetPath
]

{ #category : #'*GToolkit-Utility-File' }
FileReference >> targetPath [
	"Return the target file of the File described by aPath.  For a regular file, this is itself, for a symbolic link, it is the file pointed to by the symbolic link"
	<gtPharoPatch: #Pharo12>

	^ self symlinkEntry targetPath
]
