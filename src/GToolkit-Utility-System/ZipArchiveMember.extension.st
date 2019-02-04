Extension { #name : #ZipArchiveMember }

{ #category : #'*GToolkit-Utility-System' }
ZipArchiveMember >> gtBytes [
	<return: #ByteArray>
	| aStream |
	aStream := (ByteArray new: self uncompressedSize) writeStream.
	self extractTo: aStream.
	^ aStream contents
]

{ #category : #'*GToolkit-Utility-System' }
ZipArchiveMember >> gtContents [
	<return: #String or: #ByteArray>
	"Answer my contents as a string."
	^ self isTextFile 
		ifFalse: [ self gtBytes ] 
		ifTrue: [ self gtBytes utf8Decoded ]
]
