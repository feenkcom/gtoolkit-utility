Extension { #name : #MemoryDirectoryEntry }

{ #category : #'*GToolkit-Utility-File' }
MemoryDirectoryEntry >> targetPath [
	"Answer the Path pointing to the real file.
	MemoryStore doesn't support symbolic links, answer the receivers file"
	<gtPharoPatch: #Pharo12>

	^reference path
]
