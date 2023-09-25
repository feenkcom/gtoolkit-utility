Extension { #name : #DiskStore }

{ #category : #'*GToolkit-Utility-File' }
DiskStore >> delete: path [
	"Delete the supplied path on the receiver"
	"This is a patch to Pharo and should be removed once upstream catches up."
	<gtPharoPatch: #Pharo12>
	| pathString isSymlink |

	isSymlink := self isSymlink: path.
	((self exists: path) or: [ isSymlink ])
		ifFalse: [ ^ FileDoesNotExistException signalWith: path ].

	pathString := self stringFromPath: path.

	"Symbolic links answer true to isDirectory:, but must be deleted as a regular file"
	((self isDirectory: path) and: [ isSymlink not ]) ifTrue:
		[ File deleteDirectory: (File encodePathString: pathString) ]
	ifFalse:
		[ File deleteFile: pathString ]
]
