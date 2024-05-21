Extension { #name : #MemoryFileWriteStream }

{ #category : #'*GToolkit-Utility-System' }
MemoryFileWriteStream >> next: count putAll: collection startingAt: offset [
	"Write count characters from collection starting at offset."
	<gtPharoPatch: #Pharo>
	
	self stream 
		next: count 
		putAll: collection 
		startingAt: offset
]
