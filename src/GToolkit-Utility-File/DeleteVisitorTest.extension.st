Extension { #name : #DeleteVisitorTest }

{ #category : #'*GToolkit-Utility-File' }
DeleteVisitorTest >> testSymbolicLink [
	"The delete visitor should not follow symbolic links and should delete them as a file."
	<gtPharoPatch: #Pharo12>
	| tempDir aDir bDir symbolicLink symlinkCommand status |

	OSPlatform current isWindows ifTrue: [ ^ self ].

	[ tempDir := FileReference newTempFilePrefix: 'testSymbolLinkTargetPath' suffix: 'dir'.
	self deny: tempDir exists.
	tempDir ensureCreateDirectory.
	aDir := tempDir / 'a'.
	bDir := tempDir / 'a/b'.
	(bDir / 'c/d') ensureCreateDirectory.
	symbolicLink := bDir / 'c/sl'.

	symlinkCommand := 'cd ', (bDir / 'c') fullName, ' && ln -s ', aDir fullName, ' sl'.
	status := LibC uniqueInstance system: symlinkCommand.
	status = 0 ifFalse: [ self error: 'Unable to create symbolic link' ].

	self assert: symbolicLink isSymlink.
	self assert: symbolicLink isDirectory.
	self assert: symbolicLink targetFileReference equals: aDir.
	bDir ensureDeleteAll.
	self assert: aDir exists.
	self deny: bDir exists ]
			ensure: [ tempDir ensureDeleteAll ].

]
