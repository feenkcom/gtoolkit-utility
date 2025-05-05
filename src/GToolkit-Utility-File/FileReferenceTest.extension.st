Extension { #name : #FileReferenceTest }

{ #category : #'*GToolkit-Utility-File' }
FileReferenceTest >> testSymbolicLink [
	"The delete visitor should not follow symbolic links and should delete them as a file."
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

{ #category : #'*GToolkit-Utility-File' }
FileReferenceTest >> testSymbolicLinkTargetPath [
	<gtExample>
	<gtPharoPatch: #Pharo12>
	<return: #FileReferenceTest>
	| tempDir dDir symbolicLink symlinkCommand status |
	OSPlatform current isWindows ifTrue: [ ^ self ].

	[ tempDir := FileReference
			newTempFilePrefix: 'testSymbolLinkTargetPath'
			suffix: 'dir'.
	tempDir ensureCreateDirectory.
	dDir := tempDir / 'a/b/c/d'.
	dDir ensureCreateDirectory.
	symbolicLink := tempDir / 'a/sl'.

	symlinkCommand := 'cd ' , (tempDir / 'a') fullName , ' && ln -s '
			, dDir fullName , ' sl'.
	status := LibC uniqueInstance system: symlinkCommand.
	status = 0 ifFalse: [ self error: 'Unable to create symbolic link' ].

	self assert: symbolicLink isSymlink.
	self
		assert: (tempDir / 'a/sl/../abc') canonicalize path
		equals: (tempDir / 'a/b/c/abc') path.	"Symbolic link operations shouldn't raise an error if the target doesn't exist"
	dDir deleteAll.
	self assert: symbolicLink isSymlink.
	self
		assert: (tempDir / 'a/sl/../abc') canonicalize path
		equals: (tempDir / 'a/b/c/abc') path ] ensure: [ tempDir ensureDeleteAll ]
]
