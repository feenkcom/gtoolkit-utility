Extension { #name : #FileReference }

{ #category : #'*GToolkit-Utility-File' }
FileReference >> canonicalize [
	"Answer the receiver with references to the current folder (.) and parent folder (..) removed"
	<gtPharoPatch: #Pharo12>

	^ self withPath: (self path canonicalizeOnFilesystem: filesystem)
]

{ #category : #'*GToolkit-Utility-File' }
FileReference >> delete [
	"Deletes the referenced file or directory. If the directory is not empty,
	raises an error. Use #deleteAll to delete with the children."
	<gtPharoPatch: #Pharo12>

	(self isDirectory and:
	[ self isSymlink not and: 
	[ self hasChildren ] ])
		ifTrue:[DirectoryIsNotEmpty signalWith: self].
	filesystem delete: path
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
