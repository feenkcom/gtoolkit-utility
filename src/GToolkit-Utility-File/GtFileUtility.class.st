Class {
	#name : #GtFileUtility,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #testing }
GtFileUtility class >> contentsOf: aFileReference [
	"This should be replaced with ZnStreamingEntity usage"
	| mime |
	mime := self mimeTypeOfFileReference: aFileReference.
	^ mime isBinary
		ifTrue: [ | bytes |
			bytes := aFileReference binaryReadStreamDo: [ :aStream | 
				aStream contents ] ] 
		ifFalse: [ aFileReference contents ]
]

{ #category : #'as yet unclassified' }
GtFileUtility class >> doesFile: aFile haveExtension: aListOfExtensions [
	^ aListOfExtensions includes: aFile asFileReference extension asLowercase
]

{ #category : #'accessing - file' }
GtFileUtility class >> fileNameOf: aFileReference relativeTo: directoryFileReference [
	<return: #String>	
	| path |
	path := self pathOf: aFileReference relativeTo: directoryFileReference.
	^ path delimiter join: path segments.
]

{ #category : #'accessing - file' }
GtFileUtility class >> fileNameOfUri: aFileName [
	<return: #String or: nil>
	(aFileName beginsWith: 'file://') ifFalse: [ ^ nil ].
	^ aFileName
		copyFrom: 'file://' size + 1
		to: aFileName size.
]

{ #category : #'accessing - file' }
GtFileUtility class >> fileReferenceOfFileName: relativeFileName relativeTo: directoryFileReference [ 
	"This is basically the equivalent of `directoryFileReference / relativeFileName`, 
	which should be used in preference to this method.
	Once all senders of this method have been removed, it will be too."
	<return: #FileReference>
	| path |
	path := Path from: relativeFileName.
	^ directoryFileReference resolvePath: path.
]

{ #category : #'accessing - file' }
GtFileUtility class >> fileReferenceOfUri: aUriFileName relativeTo: directoryFileReference [
	<return: #FileReference or: nil>
	^ (self fileNameOfUri: aUriFileName) ifNotNil: [ :aFileName | 
		self fileReferenceOfFileName: aFileName relativeTo: directoryFileReference ]
]

{ #category : #'as yet unclassified' }
GtFileUtility class >> isImageFile: aString [
	^ self doesFile: aString haveExtension: #('jpeg' 'gif' 'jpg' 'png' 'svg')
]

{ #category : #'accessing - mime type' }
GtFileUtility class >> mimeTypeOfExtension: fileExtension [
	<return: #ZnMimeType>
	| mime |
	mime := GtFileMimeTypeResolver fromFileExtension: fileExtension.
	mime ifNotNil: [ ^ mime ].
	mime := ZnMimeType
		forFilenameExtension: fileExtension
		ifAbsent: [ ZnMimeType default ].
	^ mime
]

{ #category : #'accessing - mime type' }
GtFileUtility class >> mimeTypeOfFileName: fileNameString [
	<return: #ZnMimeType>
	| fileExtension |
	fileExtension := ('.' split: fileNameString) last.
	^ self mimeTypeOfExtension: fileExtension
]

{ #category : #'accessing - mime type' }
GtFileUtility class >> mimeTypeOfFileReference: aFileReference [
	<return: #ZnMimeType>
	^ self mimeTypeOfExtension: aFileReference extension
]

{ #category : #'accessing - file' }
GtFileUtility class >> pathOf: aFileReference relativeTo: directoryFileReference [
	<return: #Path>
	^ (aFileReference relativeToReference: directoryFileReference).
]

{ #category : #'accessing - file' }
GtFileUtility class >> pillarMimeType [
	^ ZnMimeType textPlain
		sub: 'pillar';
		yourself
]

{ #category : #'accessing - file' }
GtFileUtility class >> secureCharacter [
	"A character that replaces any file system unsecure characters"
	^ $-
]

{ #category : #'accessing - file' }
GtFileUtility class >> secureFileName: fileNameStringOrNil extension: extensionString [
	"Return a filename that is file system secure, e.g., does not include special characters"
	<return: #String>
	^ self 
		secureFileName: fileNameStringOrNil 
		extension: extensionString 
		maxLenght: GtFileUtilityConstants maxFileNameLenght
]

{ #category : #'accessing - file' }
GtFileUtility class >> secureFileName: aFileNameString extension: anExtensionStringOrNil maxLenght: anInteger [
	"Return a filename that is file system secure, e.g., does not include special characters"
	<return: #String>
	| aBasename |
	self assert: [ aFileNameString isNotNil ] description: [ 'Filename must be non-nil' ].
	aBasename := String 
		streamContents: [ :aStream | | previousCharacter |
			previousCharacter := nil.
			aFileNameString do: [ :eachCharacter | 
				eachCharacter isAlphaNumeric 
					ifTrue: [ aStream nextPut: eachCharacter asLowercase ]
					ifFalse: [ previousCharacter = self secureCharacter 
						ifFalse: [ aStream nextPut: self secureCharacter ] ].
				previousCharacter := eachCharacter ]
			 ] 
		limitedTo: anInteger.
	^ anExtensionStringOrNil 
		ifNotNil: [ aBasename, '.', anExtensionStringOrNil ]
		ifNil: [ aBasename ]
]

{ #category : #'accessing - file' }
GtFileUtility class >> shorterNameForFileName: aFileNameString [ 
	<return: #String>
	| aFileReference fromWorkingDir fromHomeDir |
	aFileReference := aFileNameString asFileReference.
	aFileReference exists ifFalse: [ ^ aFileNameString ]. 
	fromWorkingDir := self fileNameOf: aFileReference relativeTo: FileLocator workingDirectory asAbsolute.
	fromHomeDir := self fileNameOf: aFileReference relativeTo: FileLocator home asAbsolute.
	^ fromWorkingDir size < fromHomeDir size
		ifTrue: [ fromWorkingDir ]
		ifFalse: [ fromHomeDir ]
]

{ #category : #'storing and loading file' }
GtFileUtility class >> storeContents: aStringOrByteArray to: relativeFileName relativeTo: directoryFileReference [
	"Store the contents to a file inside of a directory."
	<return: #FileReference>
	| fileReference path subDirectory |
	path := Path from: relativeFileName.
	fileReference := directoryFileReference withPath: path.
	subDirectory := directoryFileReference.
	path segments allButLastDo: [ :eachSegment | 
		subDirectory := subDirectory / eachSegment.
		subDirectory ensureCreateDirectory ].
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :aStream | aStream nextPutAll: aStringOrByteArray ].
	^ fileReference
]
