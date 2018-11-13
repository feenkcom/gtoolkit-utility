Extension { #name : #ImageReadWriter }

{ #category : #'*GToolkit-Utility-File' }
ImageReadWriter class >> gtFormFromFileReference: aFileReference [
	<return: #Form>
	^ aFileReference binaryReadStreamDo: [ :aStream | 
			| aPositionableReadStream |
			aPositionableReadStream := ZnPositionableReadStream on: aStream.
			ImageReadWriter formFromStream: aPositionableReadStream ]
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
