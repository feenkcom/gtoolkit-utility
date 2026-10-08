Extension { #name : #Protocol }

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> gtAllProtocolDefaultName [
	^ #'All'
]

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> isAllProtocolName: aString [
	^	self gtAllProtocolDefaultName = aString
]
