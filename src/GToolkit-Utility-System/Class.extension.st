Extension { #name : #Class }

{ #category : #'*GToolkit-Utility-System' }
Class >> gtFileOut [
	"Create a file whose name is the name of the receiver with '.st' as the extension, and file a description of the receiver onto it. Answer the resulting file reference."

	| internalStream |
	internalStream := (String new: 100) writeStream.
	internalStream header; timeStamp.
	self fileOutOn: internalStream.

	^ CodeExporter gtWriteSourceCodeFrom: internalStream baseName: self name isSt: true.
]
