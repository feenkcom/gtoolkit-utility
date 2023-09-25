Extension { #name : #ImageReadWriter }

{ #category : #'*GToolkit-Utility-File' }
ImageReadWriter class >> gtFormFromFileReference: aFileReference [
	<return: #Form>

	| stream reader readerClass form fileReference |

	fileReference := aFileReference asFileReference.
	stream := GtBufferedReadStream on: 
		(fileReference fileSystem binaryReadStreamOn: fileReference path).
	form := [
		readerClass := self readerClassFromStream: stream.
		reader := readerClass new on: stream.
		reader nextImage ]
			ensure: [ stream close ].
	^ form

]

{ #category : #'*GToolkit-Utility-File' }
ImageReadWriter class >> gtReaderClassFromFileReference: aFileReference [
	"Return a class reader to a given file reference.
	Return nil, if there is not a reader that understands the file format"
	<return: #Behavior or: nil>
	^ aFileReference binaryReadStreamDo: [ :aStream | 
			| aPositionableReadStream |
			aPositionableReadStream := ZnPositionableReadStream on: aStream.
			ImageReadWriter gtReaderClassFromStream: aPositionableReadStream ]
]

{ #category : #'*GToolkit-Utility-File' }
ImageReadWriter class >> gtReaderClassFromStream: aBinaryStream [
	"Return a class reader to a given binary stream.
	Return nil, if there is not a reader that understands a stream format"
	<return: #Behavior or: nil>
	^ [ self readerClassFromStream: aBinaryStream ] 
			on: Error 
			do: [ :anException | anException return: nil ]
]
