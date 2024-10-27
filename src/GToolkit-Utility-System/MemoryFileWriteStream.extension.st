Extension { #name : #MemoryFileWriteStream }

{ #category : #'*GToolkit-Utility-System' }
MemoryFileWriteStream >> next: count putAll: collection startingAt: offset [
	"Write count characters from collection starting at offset."
	<gtPharoPatch: #Pharo>

	file closed ifTrue:
		[ (FileWriteError fileName: self localName)
				signal: self localName, ' is closed' ].
	self stream 
		next: count 
		putAll: collection 
		startingAt: offset
]
