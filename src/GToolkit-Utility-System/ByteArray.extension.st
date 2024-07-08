Extension { #name : #ByteArray }

{ #category : #'*GToolkit-Utility-System' }
ByteArray >> onHeap [
	"Copy the receiver's contents to the heap and answer its address.
	It is up to the caller to release the memory."
	| address |

	address := ExternalAddress allocate: self size.
	self primitiveCopyFrom: self
		at: 1 
		to: address 
		at: 1 
		size: self size.
]

{ #category : #'*GToolkit-Utility-System' }
ByteArray >> onHeapGC [
	"Copy the receiver's contents to the heap and answer its address"
	| address |

	address := ExternalAddress gcallocate: self size.
	self primitiveCopyFrom: self
		at: 1 
		to: address 
		at: 1 
		size: self size.
]

{ #category : #'*GToolkit-Utility-System' }
ByteArray class >> primitiveCopyFrom: src at: srcStart to: dest at: destStart size: size [
	"Use memcpy() to copy data between ExternalAddresses and ByteArrays.
	starting at: is a 1-based index.
	No buffer overflow checks are done on ExternalAddresses."
	<primitive: 'primitiveCopyFromAtToAtSize'>
	^ self primitiveFailed
]

{ #category : #'*GToolkit-Utility-System' }
ByteArray >> primitiveCopyFrom: src at: srcStart to: dest at: destStart size: size [
	"Use memcpy() to copy data between ExternalAddresses and ByteArrays.
	starting at: is a 1-based index.
	No buffer overflow checks are done on ExternalAddresses."

	self class primitiveCopyFrom: src at: srcStart to: dest at: destStart size: size
]
