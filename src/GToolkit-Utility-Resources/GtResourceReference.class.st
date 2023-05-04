"
I am like {{gtClass:FileReference}}. You can use me to dynamically resolve a resource file reference.
Users can use me to read resourcers, e.g., {{gtMethod:GtResourceReference>>#binaryReadStreamDo:}}, {{gtMethod:GtResourceReference>>#readStreamEncoded:do:}}.

Whenever I am asked to access a file or a directory, I ask {{gtClass:GtResourcesUtility}} using {{gtMethod:GtResourceReference>>#utility}} to provide me a {{gtClass:FileReference}}. See the {{gtClass:GtResourcesUtility}} class comment for more details.
1. # Convenience Usage

For the convenience, we recommend to use {{gtMethod:FileLocator class>>#gtResource}} instead of direct usage of {{gtClass:GtResourceReference}}: {{gtExample:GtResourcesUtilityExamples>>#fileLocator_withSlashes|previewExpanded=true}} 
1. # Live Search 


You can search live here by clicking on the search icon in the inspector: 
{{gtExample:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingPath|noCode|previewHeight=230}}

1. # Usage


You can either use a relative {{gtClass:Path}} to a resource:
{{gtExample:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingPath}}

Or you can pass a {{gtClass:String}} as a relative resource path:
{{gtExample:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingStringPath}}

In case of a non-existing path, it will return a possible reference inside, responding {{gtExample:GtResourcesUtilityExamples>>#gtResourceReferenceOfNotExistingPath|label=#exists}} to `exists` calls: {{gtExample:GtResourcesUtilityExamples>>#gtResourceReferenceOfNotExistingPath}}


"
Class {
	#name : #GtResourceReference,
	#superclass : #Object,
	#instVars : [
		'utility',
		'path'
	],
	#category : #'GToolkit-Utility-Resources-Core'
}

{ #category : #'instance creation' }
GtResourceReference class >> path: aPath [ 
	^ self new path: aPath
]

{ #category : #navigating }
GtResourceReference >> , anExtension [

	^ self copy path: self relativePath , anExtension
]

{ #category : #navigating }
GtResourceReference >> / aString [ 
	"Return new instance"
	^ self copyWithPath: self relativePath / aString
]

{ #category : #comparing }
GtResourceReference >> = anObject [
	(anObject respondsTo: #isEqualToResourceReference:) ifFalse: [ ^ false ].

	^ anObject isEqualToResourceReference: self
]

{ #category : #accessing }
GtResourceReference >> absolutePath [
	^ self fileReference absolutePath
]

{ #category : #accessing }
GtResourceReference >> accessTime [
	^ self fileReference accessTime
]

{ #category : #converting }
GtResourceReference >> asAbsolute [
	^ self fileReference asAbsolute
]

{ #category : #converting }
GtResourceReference >> asFileReference [
	^ self
]

{ #category : #converting }
GtResourceReference >> asPath [
	^ self path
]

{ #category : #navigating }
GtResourceReference >> asResolvedBy: anObject [

	^ anObject resolveResourceReference: self
]

{ #category : #accessing }
GtResourceReference >> asZnUrl [
	"Convert the receiver in a file:// ZnUrl"
	^ self fileReference asZnUrl
]

{ #category : #accessing }
GtResourceReference >> base [
	"Returns the base of the basename, i.e. /foo/gloops.taz base is 'gloops'"
	^ self fileReference base
]

{ #category : #accessing }
GtResourceReference >> basename [
	^ self fileReference basename
]

{ #category : #accessing }
GtResourceReference >> basenameWithoutExtension [

	^ self fileReference basenameWithoutExtension
]

{ #category : #streams }
GtResourceReference >> binaryReadStream [
	^ self fileReference binaryReadStream
]

{ #category : #streams }
GtResourceReference >> binaryReadStreamDo: doBlock [
	^ self fileReference binaryReadStreamDo: doBlock
]

{ #category : #streams }
GtResourceReference >> binaryReadStreamDo: doBlock ifAbsent: absentBlock [
	^ self fileReference binaryReadStreamDo: doBlock ifAbsent: absentBlock
]

{ #category : #streams }
GtResourceReference >> binaryReadStreamIfAbsent: absentBlock [
	^ self fileReference binaryReadStreamIfAbsent: absentBlock
]

{ #category : #streams }
GtResourceReference >> binaryWriteStream [
	"Answer a binary write stream on the receiver"
	^ self fileReference binaryWriteStream
]

{ #category : #streams }
GtResourceReference >> binaryWriteStreamDo: aBlock [
	"Pass a binary write stream on the receiver to the supplied block, and ensure that the stream is closed after evaluation."
	^ self fileReference binaryWriteStreamDo: aBlock
]

{ #category : #streams }
GtResourceReference >> binaryWriteStreamDo: doBlock ifPresent: presentBlock [
	^ self fileReference binaryWriteStreamDo: doBlock ifPresent: presentBlock
]

{ #category : #enumerating }
GtResourceReference >> childrenMatching: patterns [
	"
	FileSystem disk workingDirectory childrenMatching: '*'
	FileSystem disk workingDirectory childrenMatching: '*.image;*.changes'
	"
	^ self fileReference childrenMatching: patterns
]

{ #category : #comparing }
GtResourceReference >> contains: anObject [
	"Return true if anObject is in a subfolder of me"
	^ self fileReference contains: anObject
]

{ #category : #comparing }
GtResourceReference >> containsReference: aReference [

	^ self fileReference containsReference: aReference
]

{ #category : #comparing }
GtResourceReference >> containsResourceReference: aGtResourceReference [

	^ aGtResourceReference fileSystem = self fileSystem and: [ 
		  self relativePath contains: aGtResourceReference relativePath ]
]

{ #category : #accessing }
GtResourceReference >> contents [
	^ self fileReference contents
]

{ #category : #operations }
GtResourceReference >> copyAllTo: aResolvable [
	"Performs a deep copy of the receiver, to a location specified by the argument. If the receiver is a file, the file will be copied; if a directory, the directory and its contents will be copied recursively. The argument must be a reference that doesn't exist; it will be created by the copy."
	self fileReference copyAllTo: aResolvable
]

{ #category : #delegated }
GtResourceReference >> copyTo: aReference [
	^ self fileReference copyTo: aReference resolve
]

{ #category : #copying }
GtResourceReference >> copyWithPath: newPath [
	^ self copy path: newPath
]

{ #category : #operations }
GtResourceReference >> createDirectory [
	self fileReference createDirectory
]

{ #category : #operations }
GtResourceReference >> createFile [
	self fileReference createFile
]

{ #category : #accessing }
GtResourceReference >> creationTime [
	^ self fileReference creationTime
]

{ #category : #operations }
GtResourceReference >> delete [
	"Delete the receiver, does raise an error if it is not present."
	^ self fileReference delete
]

{ #category : #operations }
GtResourceReference >> deleteAll [
	"Delete this directory and all children of it, raise an error if the file does not exist.
	Don't follow symbolic links (so files outside the receiver's tree will not be deleted)."
	^ self fileReference deleteAll
]

{ #category : #operations }
GtResourceReference >> deleteAllChildren [
	"Delete all children of the receiver, raise an error if the receiver does not exist.
	Don't follow symbolic links (so files outside the receiver's tree will not be deleted)."
	^ self fileReference deleteAllChildren
]

{ #category : #operations }
GtResourceReference >> deleteIfAbsent: aBlock [
	"Delete the receiver, when it does not exist evaluate the block"
	^ self fileReference deleteIfAbsent: aBlock
]

{ #category : #enumerating }
GtResourceReference >> directories [
	^ self fileReference directories
]

{ #category : #operations }
GtResourceReference >> ensureCreateDirectory [
	"Verifies that the directory does not exist and only creates if necessary. Do not remove files contained if they exist.Creates the parents if needed"
	self fileReference ensureCreateDirectory
]

{ #category : #operations }
GtResourceReference >> ensureCreateFile [
	"Create if necessary a file for the receiver. If the parent does not exist creates it"
	self fileReference ensureCreateFile
]

{ #category : #operations }
GtResourceReference >> ensureDelete [
	"Delete the file and does not raise exception if it does not exist contrary to delete.
	However if it is a directory and it has children an error is signaled. If it is required to 
	delete even with children, use #ensureDeleteAll."
	self fileReference ensureDelete
]

{ #category : #operations }
GtResourceReference >> ensureDeleteAll [
	"Delete this directory and all children of it, and does not raise an error if the file does not exist."
	self fileReference ensureDeleteAll
]

{ #category : #operations }
GtResourceReference >> ensureDeleteAllChildren [
	"delete all children of the receiver and does not raise an error if the receiver does not exist"
	self fileReference ensureDeleteAllChildren
]

{ #category : #accessing }
GtResourceReference >> entries [

	^ self fileReference entries
]

{ #category : #accessing }
GtResourceReference >> entry [
	^ self fileReference entry
]

{ #category : #testing }
GtResourceReference >> exists [
	<return: #String>
	^ self fileReference exists
]

{ #category : #accessing }
GtResourceReference >> fileReference [
	<return: #FileReference>
	^ self utility resourceAtPath: self relativePath
]

{ #category : #accessing }
GtResourceReference >> fileSystem [
	^ self fileReference fileSystem
]

{ #category : #enumerating }
GtResourceReference >> files [
	^ self fileReference files
]

{ #category : #accessing }
GtResourceReference >> fullName [
	<return: #String>
	^ self fileReference fullName
]

{ #category : #accessing }
GtResourceReference >> fullPath [

	^ self fileReference fullPath
]

{ #category : #testing }
GtResourceReference >> hasChildren [
	<return: #Boolean>
	^ self fileReference hasChildren
]

{ #category : #testing }
GtResourceReference >> hasDirectories [
	<return: #Boolean>
	^ self fileReference hasDirectories
]

{ #category : #testing }
GtResourceReference >> hasFiles [
	<return: #Boolean>
	^ self fileReference hasFiles
]

{ #category : #comparing }
GtResourceReference >> hash [

	^ self relativePath hash bitXor: self utility hash
]

{ #category : #accessing }
GtResourceReference >> humanReadableSize [
	^ self fileReference humanReadableSize
]

{ #category : #testing }
GtResourceReference >> ifFile: fBlock ifDirectory: dBlock ifAbsent: aBlock [
	<return: #Boolean>
	^ self fileReference ifFile: fBlock ifDirectory: dBlock ifAbsent: aBlock
]

{ #category : #testing }
GtResourceReference >> isAbsolute [

	<return: #Boolean>
	^ self relativePath isAbsolute
]

{ #category : #testing }
GtResourceReference >> isChildOf: anObject [
	<return: #Boolean>
	^ self fileReference isChildOf: anObject
]

{ #category : #comparing }
GtResourceReference >> isContainedBy: anObject [

	^ anObject containsResourceReference: self
]

{ #category : #testing }
GtResourceReference >> isDirectory [
	<return: #Boolean>
	^ self fileReference isDirectory
]

{ #category : #comparing }
GtResourceReference >> isEqualToResourceReference: aGtResourceReference [

	^ self fileReference = aGtResourceReference fileReference
]

{ #category : #testing }
GtResourceReference >> isExecutable [
	<return: #Boolean>
	^ self fileReference isExecutable
]

{ #category : #testing }
GtResourceReference >> isFIFO [
	<return: #Boolean>
	^ self fileReference isFIFO
]

{ #category : #testing }
GtResourceReference >> isFile [
	<return: #Boolean>
	^ self fileReference isFile
]

{ #category : #testing }
GtResourceReference >> isReadable [
	<return: #Boolean>
	^ self fileReference isReadable
]

{ #category : #testing }
GtResourceReference >> isRelative [
	<return: #Boolean>
	^ self relativePath isRelative
]

{ #category : #testing }
GtResourceReference >> isRoot [
	<return: #Boolean>
	^ self fileReference isRoot
]

{ #category : #testing }
GtResourceReference >> isSocket [
	<return: #Boolean>
	^ self fileReference isSocket
]

{ #category : #testing }
GtResourceReference >> isSymlink [
	<return: #Boolean>
	^ self fileReference isSymlink
]

{ #category : #testing }
GtResourceReference >> isWritable [
	<return: #Boolean>
	^ self fileReference isWritable
]

{ #category : #navigating }
GtResourceReference >> makeRelative: anObject [
	^ anObject makeRelativeToResourceReference: self
]

{ #category : #navigating }
GtResourceReference >> makeRelativeToResourceReference: aGtResourceReference [
	^ self fullPath relativeTo: aGtResourceReference fullPath
]

{ #category : #operations }
GtResourceReference >> moveTo: aReference [
	"Move the receiver in the location passed as argument.
	
	(FileSystem disk workingDirectory / 'paf' ) ensureCreateFile.
	(FileSystem disk workingDirectory / 'fooFolder') ensureCreateDirectory. 
	(FileSystem disk workingDirectory / 'paf' ) moveTo: (FileSystem disk workingDirectory / 'fooFolder' / 'paf')
	
	Note that the receiver is modified to point to the new location."
	^ self fileReference moveTo: aReference
]

{ #category : #streams }
GtResourceReference >> openWritable: aBoolean [
	^ self fileReference openWritable: aBoolean
]

{ #category : #accessing }
GtResourceReference >> parent [

	^ self relativePath segments
		  ifEmpty: [ self fileReference parent ]
		  ifNotEmpty: [ self copyWithPath: self relativePath parent ]
]

{ #category : #accessing }
GtResourceReference >> path [
	^ self fileReference path
]

{ #category : #accessing }
GtResourceReference >> path: aStringOrPath [

	| aPath |
	aPath := aStringOrPath isString 
		ifTrue: [ aPath := Path * aStringOrPath ]
		ifFalse: [ aPath := aStringOrPath ].
		
	self 
		assert: [ (aPath isKindOf: Path) and: [ aPath isRelative ] ]
		description: [ 'Resource reference path must be a relative path' ].
		
	path := aPath
]

{ #category : #converting }
GtResourceReference >> pathString [
	^ self asPath pathString
]

{ #category : #printing }
GtResourceReference >> printOn: aStream [

	aStream nextPutAll: 'Resource '.
	self fileReference printOn: aStream
]

{ #category : #streams }
GtResourceReference >> readStream [
	^ self fileReference readStream
]

{ #category : #streams }
GtResourceReference >> readStreamDo: aBlock [
	^ self fileReference readStreamDo: aBlock
]

{ #category : #streams }
GtResourceReference >> readStreamDo: doBlock ifAbsent: absentBlock [
	^ self fileReference readStreamDo: doBlock ifAbsent: absentBlock
]

{ #category : #streams }
GtResourceReference >> readStreamEncoded: anEncoding [
	^ self fileReference readStreamEncoded: anEncoding
]

{ #category : #streams }
GtResourceReference >> readStreamEncoded: anEncoding do: aBlock [
	^ self fileReference readStreamEncoded: anEncoding do: aBlock
]

{ #category : #streams }
GtResourceReference >> readStreamIfAbsent: absentBlock [
	^ self fileReference readStreamIfAbsent: absentBlock
]

{ #category : #private }
GtResourceReference >> relativePath [

	^ path ifNil: [ path := Path * '.' ]
]

{ #category : #navigating }
GtResourceReference >> relativeTo: anObject [

	^ anObject makeRelative: self
]

{ #category : #navigating }
GtResourceReference >> relativeToPath: landmarkPath [ 
	
	^ self fullPath relativeTo: landmarkPath
]

{ #category : #navigating }
GtResourceReference >> relativeToReference: aFileReference [ 
	"Return the path of the receiver relative to landmarkReference."
	
	^ self fullPath relativeTo: aFileReference path
]

{ #category : #operations }
GtResourceReference >> renameTo: newBasename [
	self fileReference renameTo: newBasename
]

{ #category : #navigating }
GtResourceReference >> resolve [

	<return: #GtResourceReference>
	^ self
]

{ #category : #navigating }
GtResourceReference >> resolve: anObject [

	<return: #GtResourceReference or: #FileReference>
	^ anObject asResolvedBy: self
]

{ #category : #navigating }
GtResourceReference >> resolvePath: anObject [

	<return: #GtResourceReference>
	^ self withPath: (self relativePath resolve: anObject)
]

{ #category : #navigating }
GtResourceReference >> resolveReference: aReference [

	<return: #GtResourceReference or: #FileReference>
	| aFileSystem |
	aFileSystem := self fileSystem.

	^ (aFileSystem = aReference fileSystem or: [ aReference isRelative ])
		  ifTrue: [ 
		  	self copyWithPath: (self relativePath resolvePath: aReference path) ]
		  ifFalse: [ aReference ]
]

{ #category : #navigating }
GtResourceReference >> resolveResourceReference: aResource [

	<return: #GtResourceReference>
	^ self fileSystem = aResource fileSystem
		  ifTrue: [ 
			  self copyWithPath:
				  (self relativePath resolvePath: aResource relativePath) ]
		  ifFalse: [ aResource ]
]

{ #category : #navigating }
GtResourceReference >> resolveString: aString [

	<return: #GtResourceReference>
	| filesystem thePath |
	filesystem := self fileSystem.
	thePath := filesystem pathFromString: aString.
	^ self withPath: (path resolvePath: thePath)
]

{ #category : #accessing }
GtResourceReference >> results [
	<return: #Array of: #GtResourcesUtilityResultContext>
	^ self utility locationsAtPath: self relativePath
]

{ #category : #accessing }
GtResourceReference >> size [
	"Return the size of the file in bytes."
	<return: #Integer>
	^ self fileReference size
]

{ #category : #streams }
GtResourceReference >> streamWritable: writable do: aBlock [
	^ self fileReference streamWritable: writable do: aBlock
]

{ #category : #accessing }
GtResourceReference >> utility [
	^ utility ifNil: [ GtResourcesUtility default ]
]

{ #category : #accessing }
GtResourceReference >> utility: anObject [
	utility := anObject
]

{ #category : #navigating }
GtResourceReference >> withExtension: aString [
	| aNewPath |
	aNewPath := self relativePath withExtension: aString.
	(self relativePath == aNewPath) ifTrue: [ ^ self ].
	^ self copyWithPath: aNewPath
]

{ #category : #accessing }
GtResourceReference >> withParents [
	<return: #Array of: #FileReference>
	^ self fileReference withParents
]

{ #category : #navigating }
GtResourceReference >> withPath: newPath [
	^ self relativePath == newPath
		ifTrue: [ self ] 
		ifFalse: [ self copyWithPath: newPath ]
]

{ #category : #streams }
GtResourceReference >> writeStream [
	^ self fileReference writeStream
]

{ #category : #streams }
GtResourceReference >> writeStreamDo: aBlock [
	^ self fileReference writeStreamDo: aBlock
]

{ #category : #streams }
GtResourceReference >> writeStreamDo: doBlock ifPresent: presentBlock [
	^ self fileReference writeStreamDo: doBlock ifPresent: presentBlock
]

{ #category : #streams }
GtResourceReference >> writeStreamEncoded: anEncoding [
	^ self fileReference writeStreamEncoded: anEncoding
]

{ #category : #streams }
GtResourceReference >> writeStreamEncoded: anEncoding do: aBlock [
	^ self fileReference writeStreamEncoded: anEncoding do: aBlock
]

{ #category : #streams }
GtResourceReference >> writeStreamIfPresent: presentBlock [
	^ self fileReference writeStreamIfPresent: presentBlock
]
