Extension { #name : #MemoryStore }

{ #category : #'*GToolkit-Utility-File' }
MemoryStore >> symlinkEntryAt: aPath fileSystem: aFilesystem [
	"MemoryStore doesn't support symbolic links, so a standard entry can be used"
	<gtPharoPatch: #Pharo12>

	^ MemoryDirectoryEntry reference: (aFilesystem referenceTo: aPath)
]
