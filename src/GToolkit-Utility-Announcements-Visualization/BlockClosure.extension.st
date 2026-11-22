Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
BlockClosure >> gtAddActionToAnnouncerGraph: aGraph from: aSubscriptionNode [
	| aBlockNode |
	aBlockNode := aGraph blockNodeFor: self.
	aGraph strongFrom: aSubscriptionNode to: aBlockNode label: 'action'.
	self receiver
		ifNotNil: 
			[:aReceiver |
			aGraph
				backReferenceFrom: aBlockNode
				to: (aGraph capturedNodeFor: aReceiver)
				label: 'receiver'].
	1 to: self numCopiedValues
		do: 
			[:anIndex |
			(self copiedValueAt: anIndex)
				ifNotNil: 
					[:aCapturedObject |
					aGraph
						backReferenceFrom: aBlockNode
						to: (aGraph capturedNodeFor: aCapturedObject)
						label: 'captured']]
]

{ #category : #'*GToolkit-Utility-Announcements-Visualization' }
BlockClosure >> gtAnnouncerGraphActionDescription [
	^'a block'
]
