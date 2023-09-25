Extension { #name : #File }

{ #category : #'*GToolkit-Utility-File' }
File class >> primFileAttribute: aByteArray number: attributeNumber [
	"Answer a single attribute for the supplied file.
	For backward compatibility (on Unix) with FileReference if the file doesn't exist, and the specified path is a (broken) symbolic link, answer the requested attribute for the symbolic link.

stat() information:

	1: name
	2: mode
	3: ino
	4: dev
	5: nlink
	6: uid
	7: gid
	8: size
	9: accessDate
	10: modifiedDate
	11: changeDate
	12: creationDate

access() information

	13: is readable
	14: is writeable
	15: is executable

symbolic link information

	16: is symbolic link
	"
	"This is a patch to Pharo and should be removed once upstream catches up."
	<gtPharoPatch: #Pharo12>
	<primitive: 'primitiveFileAttribute' module: 'FileAttributesPlugin' error: error>
	"FilePlugin>>primitiveDirectoryEntry would return the symbolic link attributes if the symbolic link was broken.  This was due to the incorrect implementation of attempting to retrieve symbolic link information.
	If the old behaviour is required, the logic is:

		(error isPrimitiveError and: [attributeNumber ~= 16 and: [error errorCode = self cantStatPath and: [
					self platformSupportsSymbolicLinksEgUnix]]]) ifTrue:
						[DiskSymlinkDirectoryEntry fileSystem: DiskStore currentFileSystem path: aString asPath]"
	error isPrimitiveError ifTrue: [
		"If symlinks aren't supported or the supplied path doesn't exist, answer false"
		(attributeNumber = 16 and: 
			[ error errorCode = self unsupportedOperation or:
			[ error errorCode = self cantStatPath ] ]) ifTrue:
				[ ^false ] ].
	^self signalError: error for: aByteArray
]
