Extension { #name : #Protocol }

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> gtAllProtocolDefaultName [
	^ #'All'
]

{ #category : #'*GToolkit-Utility-System' }
Protocol class >> isAllProtocolName: aString [
	^ self 
		forPharo12AndNewer: [
			self unclassified = aString or: [ 
				self gtAllProtocolDefaultName = aString ]]
		forPharo11: [ 
			self defaultName = aString or: [ 
				self gtAllProtocolDefaultName = aString or: [ 
					self nullCategory = aString ] ] ]
]
