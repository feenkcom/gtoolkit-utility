Extension { #name : #AllProtocol }

{ #category : #'*GToolkit-Utility-System' }
AllProtocol class >> gtDefaultName [
	^ 'All'
]

{ #category : #'*GToolkit-Utility-System' }
AllProtocol class >> isAllProtocolName: aString [
	^ self defaultName = aString
		or: [ self gtDefaultName = aString or: [ self nullCategory = aString ] ]
]
