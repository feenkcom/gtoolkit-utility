Extension { #name : #WindowsStore }

{ #category : #'*GToolkit-Utility-File' }
WindowsStore >> printPath: aPath on: aStream [
	<gtPharoPatch: #Pharo12>
	| hasDrive firstSegment |

	aPath isNetworkPath
		ifTrue: [ ^ aPath printOn: aStream delimiter: self delimiter ].

	aPath isRoot
		ifTrue: [ ^ self ].	"effectively Windows root is empty string"

	aPath isWorkingDirectory
		ifTrue: [ ^ aPath printOn: aStream delimiter: self delimiter ].
	aPath isRelative
		ifTrue: [ ^ aPath printOn: aStream delimiter: self delimiter ].
	aPath segments first first = $:
		ifTrue: [ ^ aStream nextPut: self delimiter ].	"as tagged in #pathFromString:  "
	firstSegment := aPath segments first.
	hasDrive := firstSegment size >= 2 and: [ firstSegment second = $: ].
	hasDrive ifFalse: [ aStream nextPut: self delimiter ].
	aPath printOn: aStream delimiter: self delimiter.
	(hasDrive and: [ aPath segments size = 1 ])
		ifTrue: [ aStream nextPut: self delimiter ]
]
