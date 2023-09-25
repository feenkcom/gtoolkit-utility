Class {
	#name : #FileReferenceExamples,
	#superclass : #AbstractFileReferenceExamples,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
FileReferenceExamples >> rootDirectory [
	| aReference |
	aReference := FileLocator root asFileReference.

	self assert: (aReference isKindOf: FileReference).

	^ aReference
]

{ #category : #examples }
FileReferenceExamples >> testCanonicalization [
	<gtExample>
	| ref |

	ref := 'a/b/c' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'b' 'c').

	ref := '/a/b/c' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'b' 'c').

	ref := '../a/b/c' asFileReference canonicalize.
	self assert: ref path segments equals: #('..' 'a' 'b' 'c').

	ref := 'a/b/c/..' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'b').

	ref := '/a/b/c/..' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'b').

	ref := 'a/b/../c' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'c').

	ref := '/a/b/../c' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'c').

	ref := '/..' asFileReference canonicalize.
	self assert: ref path segments isEmpty.

	ref := '/../a/b/../c' asFileReference canonicalize.
	self assert: ref path segments equals: #('a' 'c')
]

{ #category : #examples }
FileReferenceExamples >> testSymbolicLink [
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
	self assert: symbolicLink targetFileReference = aDir.
	bDir ensureDeleteAll.
	self assert: aDir exists.
	self deny: bDir exists ]
			ensure: [ tempDir ensureDeleteAll ].

]

{ #category : #examples }
FileReferenceExamples >> testSymbolicLinkTargetPath [
	<gtExample>
	| tempDir dDir symbolicLink symlinkCommand status |

	OSPlatform current isWindows ifTrue: [ ^ self ].

	[ tempDir := FileReference newTempFilePrefix: 'testSymbolLinkTargetPath' suffix: 'dir'.
	tempDir ensureCreateDirectory.
	dDir := tempDir / 'a/b/c/d'.
	dDir ensureCreateDirectory.
	symbolicLink := tempDir / 'a/sl'.

	symlinkCommand := 'cd ', (tempDir / 'a') fullName, ' && ln -s ', dDir fullName, ' sl'.
	status := LibC uniqueInstance system: symlinkCommand.
	status = 0 ifFalse: [ self error: 'Unable to create symbolic link' ].

	self assert: symbolicLink isSymlink.

	self assert: (tempDir / 'a/sl/../abc') canonicalize path
		equals: (tempDir / 'a/b/c/abc') path.

	"Symbolic link operations shouldn't raise an error if the target doesn't exist"
	dDir deleteAll.
	self assert: symbolicLink isSymlink.
	self assert: (tempDir / 'a/sl/../abc') canonicalize path
		equals: (tempDir / 'a/b/c/abc') path ]
			ensure: [ tempDir ensureDeleteAll ].

]

{ #category : #accessing }
FileReferenceExamples >> workingDirectory [
	| aReference |
	aReference := FileLocator workingDirectory asFileReference.

	self assert: (aReference isKindOf: FileReference).

	^ aReference
]
