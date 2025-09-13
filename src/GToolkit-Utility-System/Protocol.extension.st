Extension { #name : #Protocol }

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> gtAllProtocolDefaultName [
	^ #'All'
]

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> isAllProtocolName: aString [
	^ self 
		forPharo12AndNewer: [
			self gtAllProtocolDefaultName = aString ]
		forPharo11: [ 
			self gtAllProtocolDefaultName = aString or: [ 
				self nullCategory = aString ] ] 
]
