Extension { #name : #CodeExporter }

{ #category : #'*GToolkit-Utility-System' }
CodeExporter class >> gtWriteSourceCodeFrom: aStream baseName: baseName isSt: stOrCsFlag [

	| extension targetFile |
	extension := stOrCsFlag ifTrue: ['st']  ifFalse: ['cs'].
	targetFile := FileLocator imageDirectory / baseName asFileName, extension.

	self writeSourceCodeFrom: aStream toFileReference: targetFile.
	^ targetFile
]
