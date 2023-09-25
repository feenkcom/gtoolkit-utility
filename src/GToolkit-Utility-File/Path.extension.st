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
	"Since this path is relative we don't know what it will be resolved against.
	Canonicalize assuming no symbolic links"
	<gtPharoPatch: #Pharo12>

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
	"Answer the receiver with references to the current folder (.) and parent folder (..) removed"
	<gtPharoPatch: #Pharo12>

	^self class withAll: (self class 
		canonicalizeElements: self segments 
		filesystem: filesystem)
]
