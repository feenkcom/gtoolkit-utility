Extension { #name : #Path }

{ #category : #'*GToolkit-Utility-File' }
Path class >> addElement: element to: result on: filesystem [
	<gtPharoPatch: #Pharo12>

	element = '..'
		ifTrue: [ ^ self addParentElementTo: result on: filesystem ].
	element = ''
		ifTrue: [ ^ self addEmptyElementTo: result ].
	element = '.'
		ifFalse: [ result add: element ]
]

{ #category : #'*GToolkit-Utility-File' }
Path class >> addParentElementTo: result on: filesystem [
	"The parent directory may be a symbolic link, in which case it must be resolved to its target path before determining the result."
	<gtPharoPatch: #Pharo12>

	result ifNotEmpty:
		[ | parentReference entry |
		parentReference := filesystem referenceTo: (self withAll: result).
		entry := parentReference symlinkEntry.
		entry isSymlink ifTrue:
			[ result removeAll.
			result addAll: entry targetPath segments ] ].

	(result isEmpty or: [ result last = '..' ])
		ifTrue: [ result add: '..' ]
		ifFalse: [ result removeLast ]
]

{ #category : #'*GToolkit-Utility-File' }
Path class >> canonicalizeElements: aCollection filesystem: filesystem [
	<gtPharoPatch: #Pharo12>
	| result |

	result := OrderedCollection new.
	aCollection do: [ :element |
		self addElement: element to: result on: filesystem ].
	^ result
]

{ #category : #'*GToolkit-Utility-File' }
Path >> canonicalizeOnFilesystem: filesystem [
	<gtPharoPatch: #Pharo12>
	"Answer the receiver with references to the current folder (.) and parent folder (..) removed"

	^self class withAll: (self class 
		canonicalizeElements: self segments 
		filesystem: filesystem)
]
